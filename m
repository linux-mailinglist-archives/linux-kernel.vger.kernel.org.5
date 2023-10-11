Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B24E7C5958
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjJKQlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjJKQlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:41:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9210891
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:41:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DB0C433C7;
        Wed, 11 Oct 2023 16:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697042476;
        bh=hejh49+2QJYUTv/+mj/o5LoRRT/U0icOUjD72vSPqFY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D2uDkKIO6qFka1E/H1MPofJv0xZKXnhqqQeemZgDdoL97jDFj3u+R1OKQtU5wcXp/
         YLov0IhajJJu2nhyT0egq/WSQ45qaIAYKTW6uRuRN3k5cWyg1RCvM/3s8+PDZYk6Er
         S3RTx7vwBRMdgK0g5bTjHd674CMJeGkK2sS+hA67XQNnlkwlUIHi5vemHPQzJ8Eq9P
         6XijW+Z5bioIdbaTRnzbgRpOcs+VCxxFqhI+cdbaAE2MxoruSal/FHp/tOlWNLEDSP
         tW49wzRAMztLeirvCgB4tXverg+HJU6+ujzBjs2fmKWgtTJlvn9iC1a/dIweOYojD0
         FlVFjA5fFpphA==
Date:   Wed, 11 Oct 2023 09:41:14 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     takeru hayasaka <hayatake396@gmail.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ethtool: ice: Support for RSS settings to GTP
 from ethtool
Message-ID: <20231011094114.4d8f24c7@kernel.org>
In-Reply-To: <CADFiAcL-kAzpJJ+KAkvw2tH8H0-21kyOusPSPybcmkf3CM7w9g@mail.gmail.com>
References: <20231008075221.61863-1-hayatake396@gmail.com>
        <20231010123235.4a6498da@kernel.org>
        <CADFiAcKF08osdvd4EiXSR1YJ22TXrMu3b7ujkMTwAsEE8jzgOw@mail.gmail.com>
        <20231010191019.12fb7071@kernel.org>
        <CADFiAcL-kAzpJJ+KAkvw2tH8H0-21kyOusPSPybcmkf3CM7w9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 14:25:55 +0900 takeru hayasaka wrote:
> > Regarding the patch - you are only adding flow types, not a new field
> > (which are defined as RXH_*). If we want to hash on an extra field,
> > I think we need to specify that field as well?  
> 
> I've been really struggling with this...
> When I read the Intel ICE documentation, it suggests that in RSS, TEID
> can be an additional input.
> However, I couldn't think of a reason not to include TEID when
> enabling RSS for GTP cases.
> 
> https://www.intel.com/content/www/us/en/content-details/617015/intel-ethernet-controller-e810-dynamic-device-personalization-ddp-technology-guide.html
> (cf. Table 8. Patterns and Input Sets for iavf RSS)
> 
> However, for Flow Director, it's clear that you'd want to include the
> TEID field. But since I found that someone from Intel has already
> configured it to use TEID with Flow Director, I thought maybe we don't
> need to add the TEID parameter for now.
> 
> https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20210126065206.137422-1-haiyue.wang@intel.com/
> 
> If we want to include something other than TEID (e.g., QFI) in Flow
> Director, I think it would be better to prepare a new field.

I think we should expose TEID as a field. It's easier to understand 
the API if fields are all listed, and not implied by the flow hash.
