Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3ED37CFED6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346405AbjJSP5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346461AbjJSP5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:57:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371BA19F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:57:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10B0C433C8;
        Thu, 19 Oct 2023 15:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697731063;
        bh=aV4zjqdTfT5hQ+Z2OY2yVVJ9007OGiHOsvnzeD0O/ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R7amKmKhwgcduuPk4cZHH2A/v5VghUZCV1R05tamsUU4eMloSv38OcUTUeQcP7two
         AT9p3bjWlWF9hjZOYORos4KTOdS1mGajy0CdSBmlrAFlVggnJmH/HRgCP2SAO80TvQ
         dtgSi27oCjKwrSotT8ejuUHuhN+fJnYQnmh4cvqsQwei5gyOHCihrnCOGJemI9eog4
         +S0Fqv4wXJpgLQvJtQjsjdYQ7gbalJff2P96sUn6pGX8VJzLbVi7N6jVLeQYZZ1iCz
         TD4mWA+Sbl8e3qh3S7iur6g5ugg3AydfpeC1l3UtiTZliE+TFNnfiK9c/9nXpz9+It
         QfcmeyoL6PKKw==
Date:   Thu, 19 Oct 2023 17:57:35 +0200
From:   Simon Horman <horms@kernel.org>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc:     Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        George Cherian <george.cherian@marvell.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Coiby Xu <coiby.xu@gmail.com>,
        Brett Creeley <brett.creeley@amd.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Aya Levin <ayal@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, Benjamin Poirier <bpoirier@suse.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next v3 06/11] octeontx2-af: devlink health: use
 retained error fmsg API
Message-ID: <20231019155735.GO2100445@kernel.org>
References: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
 <20231018202647.44769-7-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018202647.44769-7-przemyslaw.kitszel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:26:42PM +0200, Przemek Kitszel wrote:
> Drop unneeded error checking.
> 
> devlink_fmsg_*() family of functions is now retaining errors,
> so there is no need to check for them after each call.
> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

