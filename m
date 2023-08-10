Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E688B777C86
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbjHJPoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjHJPoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:44:20 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280F31BF7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:44:20 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 56BEB40E01A1;
        Thu, 10 Aug 2023 15:44:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tveBbQ0QXucv; Thu, 10 Aug 2023 15:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691682256; bh=Xozx9w0nb0I/YnaTC+tGLrHAjYsgyRkQu9HooKs08LU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QTxMm6s3ji6JUY9iX6C8qvplPviNRmgNlmCGg5vkcWbxpD1uX+v1LvVJ4/3KFTFz1
         w/5lXeMXyxOe/afCewxFc43A3isJPL8ijPt9QFfnuwMuYsURYLsQ3t6B/QL6LOnYto
         9mC1ihbkXT6I0hdtmJdW0yndmQUncoW6Z9qj75PnG9tzLbbWO3AD1ktdtmi0rWgrGK
         BhcKD6DgTCpn4xwPpEZNmY6Q6FnTz+LxFy17Qb87mLCExRHDgp7hU+xVej0UPXHUY9
         mYxMVDdxqdmABUfvlamVmTVcMspt6K+ictsELenblQ60yLpZ8XY1a/g9TySnQlEddc
         1nkKlvV6yDpVmmprbMSyVR3eSpmZte2HKQVy5aLxolyeT28PWvAUhMm3SqGd44hRjd
         rhyrvf8qIXTreQxe6RYL41neKuyuqu30yJ3Y4tBLlNmjMtLSeQZTKH0iZpGZq9es30
         sKvo5+9WFFcKwVNBuG2KBTwtcms4nfwE0Iw5+jpG1iY+ZvY3bbf99wZcqYRs718Lqm
         D1c63Z9LWtE8JPHz91NDuAE6BSUAeM7utli7HHhfKXBl4/c1CJlwxSLdSHoIGEEdoM
         NFcUA+qZ4JEnWxhrkC4zfAtpPeh7OyhxbPX8opOl+c3T2J6oFs/tQ29u8lh5GKC7ee
         oI/6Xd9kYKItWE0mRxHta21o=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D38A540E0185;
        Thu, 10 Aug 2023 15:44:08 +0000 (UTC)
Date:   Thu, 10 Aug 2023 17:44:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 06/17] x86/cpu: Add SRSO untrain to retbleed=
Message-ID: <20230810154404.GOZNUFxHxLIMth6j9s@fat_crate.local>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.850338672@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809072200.850338672@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:12:24AM +0200, Peter Zijlstra wrote:
> Since it is now readily apparent that the two SRSO
> untrain_ret+return_thunk variants are exactly the same mechanism as
> the existing (retbleed) zen untrain_ret+return_thunk, add them to the
> existing retbleed options.

Except that Zen3/4 are not affected by retbleed, according to my current
state of information.

I don't like this lumping together of the issues even if their
mitigations are more or less similar.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
