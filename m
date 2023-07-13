Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC32751874
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjGMGBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjGMGBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:01:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCA12101
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:01:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D37B61A1B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE8AC433C7;
        Thu, 13 Jul 2023 06:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689228073;
        bh=w+P5mRmNhuaIFNb8g78p5+MFYDSB8dr91PCPz9ZsAXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JL/vxpsWci8zWey466CpqtRF1IqCZhLnR6XndgpkytQkfb/silNbeElL0xnXg92kj
         1VJH8awQwE24zQ3y0UPNbRuOCFnpe465ubXwPf+ped/wR1yALdAnGAFsvdWKmTWcLU
         V2p421BzdUFiZGHQDiSxnfnPijJM2FTjM0vfhEdI=
Date:   Thu, 13 Jul 2023 08:01:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= 
        <machel@vivo.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjFdIGxp?=
 =?utf-8?Q?b=3AFix_an_NUL?= =?utf-8?Q?L?= vs IS_ERR() bug for
 debugfs_create_dir() in err_inject_init()
Message-ID: <2023071334-tattle-mobile-dab4@gregkh>
References: <20230712135226.10041-1-machel@vivo.com>
 <2023071202-varsity-evasion-580b@gregkh>
 <SG2PR06MB37435A03DEC11F265C849093BD37A@SG2PR06MB3743.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SG2PR06MB37435A03DEC11F265C849093BD37A@SG2PR06MB3743.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Jul 13, 2023 at 02:09:03AM +0000, 王明-软件底层技术部 wrote:
> Hi greg k-h
> I proposed this patch because I found that debugfs_create_dir() does
> not return NULL, but returns an error pointer, executing if statements
> according to the original code meaning no error, so I made this change
> : )

That's fine, but you should fix this up to use the api properly if you
are making these types of changes, otherwise we just have to do it again
in the future.

thanks,

greg k-h
