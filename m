Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B74877990D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjHKU7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjHKU7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:59:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB5035AC;
        Fri, 11 Aug 2023 13:59:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0E2965AA5;
        Fri, 11 Aug 2023 20:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0393C433C7;
        Fri, 11 Aug 2023 20:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691787576;
        bh=kdOkYOLUIHXvpGrXXLNbvMVFBY5bjHVGpejjL6TXi+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UdYSsKSDT5puBMDQgCfso6AoxmNYinDHjhuqqDe0ajCer3AbOx8YVG8iQi3HsMbV+
         o57KmNkTGERDZIVfzA2xXXI9PFMJuhaRDLa68W5mvO/XcF/8UNghtfLdyGab0cbYfQ
         GiYVsHpCdhyjR+aTo3GPhp+Ev/fsfTtf1zq2O3sYqetbmtCT6KIAHTFYtUH53IMABj
         7R9Pm2I5bYbN9QaX/mdlKvL+8f3l7rOvJmi1RmfX3E9wMdxO2xssUlWG6oi1j+qGXZ
         WhnObYYeFf+8HK7QXm3zweML0JPQc6s2Kq0fdfvQuzzdt0OURKyHP9CxlB0a/drdky
         WRq50273Bcwgw==
Date:   Fri, 11 Aug 2023 14:59:33 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     August Wikerfors <git@augustwikerfors.se>
Cc:     stable@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Christoph Hellwig <hch@lst.de>, axboe@fb.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        nilskruse97@gmail.com, David.Chang@amd.com
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
Message-ID: <ZNahNYGd3L8YYtiQ@kbusch-mbp.dhcp.thefacebook.com>
References: <ZMgHE2wu4T4OfrTR@kbusch-mbp>
 <040c5788-1a7b-26ea-23cc-ba239c76efa9@augustwikerfors.se>
 <39697f68-9dc8-7692-7210-b75cce32c6ce@amd.com>
 <20230731201047.GA14034@lst.de>
 <36319a0f-34a6-9353-bc52-4d4d0fac27a5@amd.com>
 <20230801112403.GA3972@lst.de>
 <ae7fb9b2-d692-f9b8-5130-4555cc489846@amd.com>
 <ZMlrGNw5OMW3yxId@kbusch-mbp.dhcp.thefacebook.com>
 <b2e741b3-b581-40fe-2c28-e4660f52003d@amd.com>
 <0f422dbe-2e3f-4401-be87-2963cbbc1234@augustwikerfors.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f422dbe-2e3f-4401-be87-2963cbbc1234@augustwikerfors.se>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 10:19:35PM +0200, August Wikerfors wrote:
> On 2023-08-01 22:34, Mario Limonciello wrote:
> > If you can still change it before sending out can you add a stable tag
> > as well?
> 
> This didn't get added in time, so, stable team, please backport:
> 
> 688b419c57c1 ("nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and 512G")

Perhaps bad form on my end for relying on it, but in my experience, the
stable bot has a great record on auto selecting nvme quirks.
