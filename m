Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F187C7635B3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjGZLzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjGZLzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:55:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019EB106
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:55:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5556761ADB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F7AC433CB;
        Wed, 26 Jul 2023 11:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690372504;
        bh=5bSCzRai7BDolec9wDv9JgFOcpS52Iak09xrBEf8yiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N8xqPWPAfRjQd2Uh5S6GLG9JqxvkX7NFJrLHo9O/8oAHt/fPKpr9IL+5oPQejvhJq
         VEw2VOV0KAn6PFjBSnJxOjQFV6z35kcGq9XjU1pJcXW1a3F4W1dl9aMFDZC+gxpQOA
         vxnCcB2KHM/6Pl8aMpAB8ObiAWJSlOc9MTwKlU04d5sN3RVhoxHVPzMw9piYVLVnUa
         Byzbsv+tZSVneo/8xrtLvfEIvitiZxNu+6OdYE4ISCpbr/jsFlcjktg5ilCxlpjfXT
         8gVFe01Yz5hNO0upNZqIQx9peBzbSR2HEn2Y6QC05E9zLLgEJubLa/MR06Bv6YSAcB
         0ZGB3H4rZXqeg==
Date:   Wed, 26 Jul 2023 14:55:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] xfrm: add forgotten nla_policy for XFRMA_MTIMER_THRESH
Message-ID: <20230726115500.GV11388@unreal>
References: <20230723074110.3705047-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723074110.3705047-1-linma@zju.edu.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 03:41:10PM +0800, Lin Ma wrote:
> The previous commit 4e484b3e969b ("xfrm: rate limit SA mapping change
> message to user space") added one additional attribute named
> XFRMA_MTIMER_THRESH and described its type at compat_policy
> (net/xfrm/xfrm_compat.c).
> 
> However, the author forgot to also describe the nla_policy at
> xfrma_policy (net/xfrm/xfrm_user.c). Hence, this suppose NLA_U32 (4
> bytes) value can be faked as empty (0 bytes) by a malicious user, which
> leads to 4 bytes overflow read and heap information leak when parsing
> nlattrs.
> 
> To exploit this, one malicious user can spray the SLUB objects and then
> leverage this 4 bytes OOB read to leak the heap data into
> x->mapping_maxage (see xfrm_update_ae_params(...)), and leak it to
> userspace via copy_to_user_state_extra(...).
> 
> The above bug is assigned CVE-2023-3773. 

This CVE is a joke, you need to be root to execute this attack.

Anyway change is ok.
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
