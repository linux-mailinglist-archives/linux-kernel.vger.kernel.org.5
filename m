Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157B2777747
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbjHJLiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbjHJLh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:37:57 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58612D4A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:37:52 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D40C140E0185;
        Thu, 10 Aug 2023 11:37:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dyLYOwkNCFuw; Thu, 10 Aug 2023 11:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691667468; bh=/2tnPFLw5mb2iAyfEp04Lxf42Q933p9aHH5odv7/L+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mg1ob5P2yijMLWJy7JX4vOlK+c2j0gbeeTzLdMDIHnrDjVyUs44Gba5xbrmTN2KVU
         UD9NwMGkhN2gzITffHvTlyxZq+Wxrssi9QYemBsi/yEW3ddPT5dtksmewPBGFFQUnE
         5flfTYGMMymgFSZ3PJyUwrSggXZcfqF8aMUAkxspt+SkiEa1wf1S/TTWyIHWFqzG6t
         zENkuF2ruYgnFVV4Flh4x2LXeL+mf5ITfZLS1U+NNl74Lnsxj9l8kb8vA26xBOitcJ
         MH4Wl8byk/jNXZ12lBg0w3prLf7Xwc2v+P9KeSpmyV38qsZTmbzZQS+kHUBiczgqLP
         hbYdsp6UlSD+5+26qP1dAlA2QpeQLPIlzckSVy256CKcntYjeOCPzXZisfdcZvqRJo
         +HyN+zyvk1ykCwQm+M0fRxlmF3sH40SaOKnaFkgLZBtCpbz21APDF7d+X/TIcGSTVh
         +8oLMFhzTNW7f2Mt3HRwMgXoCsyK/gnRFvvo642soiGi0ISFKgaxEMTgT09mzWA0l4
         7pYy5E3cLNtJ/+o8d/at5BbdoRHmIcq+MrBEKYc35GuCLQ2FPoPD8nL8zKdwMqy4kS
         v1N2MGhMCpcpVGXGx+Jb+henmBLgPz5iUyp8MIJ9F18dfSrRJFMy9wRf4x2QJZIoY6
         qsa21k7LKB9LZSF4nXvMpGRE=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6165C40E01A0;
        Thu, 10 Aug 2023 11:37:41 +0000 (UTC)
Date:   Thu, 10 Aug 2023 13:37:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 01/17] x86/alternative: Unconditional custom return
 thunk
Message-ID: <20230810113736.GDZNTMAGTbzwxSdjbx@fat_crate.local>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.450404700@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809072200.450404700@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:12:19AM +0200, Peter Zijlstra wrote:

Please add a verb to the subject:

"Make the custom return thunk unconditional"

or so.

> There is infrastructure to rewrite return thunks to point to any
> random thunk one desires, unwrap that from CALL_THUNKS, which up to
> now was the sole user of that.

And yes, provided we can do the thing in the next patch which makes
sense to me, ack.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
