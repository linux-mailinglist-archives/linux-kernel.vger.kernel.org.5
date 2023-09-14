Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9417A11D6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 01:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjINXbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 19:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjINXbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:31:21 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDAF3C14
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:30:36 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2745cd2ba68so1312334a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 16:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694734236; x=1695339036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L5Atq17mYlT6kG+rBiO4juTIlMt9CxnTqo+M16pkWhM=;
        b=dEQQvojIaPClf9MI5PCpnvAZyss1vL2gH0ndC1RoEbHw2R/H0bTZpiTwk/8rFYFY6z
         7BDa04ukYfbe5meZzc/B3/MeDj0YREjaf5v+db9IGwlAARvPGylXAnqMuY08vbRQDHMW
         acxpUhtrDC10zo5PDmj1+bhxp+bcDNeTZPvXkJQ/ESsdcc7iMea0r1k+8wbmv3hKbPzk
         BkpoJIJ1OrGOMQsU6sNKbrSVz6S0CTMoJwOvNAvtg1pR6IaGIfZeH5WRvnHZ5kzPECcI
         ztTM6IRBrg3hCN3U0sTkOttaHW6z7jzU9nxkl/3d+alxtVmGsFxQwXbTUOevGiE7CJA1
         8TAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694734236; x=1695339036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5Atq17mYlT6kG+rBiO4juTIlMt9CxnTqo+M16pkWhM=;
        b=w2SHlbkz0FebYcc/Dja1z+uI0wbuWrtoU4fIu9JRxT+fCdceXibEGESf9uveQQ6OOA
         p2epUVGm3rh/MHbEADwkzQ0oD5tgXRtw03K3DIO4JWNLx5sLkOiV5RBQQjuf1RJ2P32A
         1+f9vsythJ4iFhAJa3thDSrnuveqM3JVrytItqRrdC52SeqPHp4ZSASa2+DiwYUmEHtm
         zKNkPAO9TJ6K7XPb9KRuG9Wmp9ATB1K7jHci7aUMpGL7b4fXjjV/ooaWNp7Qk2qs18YQ
         KP6MJ/ZvRkWT4Fmu4tyGON2ErTwQjaDubDkShlTINneihTRUkYYa/QFBWDUXLWufUlll
         t9Kg==
X-Gm-Message-State: AOJu0Yy6rBpTBSc/BpxUCZTkJf42XvT2Hpps9xW8feQSAn0KIQvzHQ+3
        IC058tLbvoMMNVftGnHel+5bMA==
X-Google-Smtp-Source: AGHT+IHTae6MGOouJH7+uAsD0l07KjxO1N76fOI883eWFzpYbooJalY2ts/KiMx+iHvSfJFWDphUKQ==
X-Received: by 2002:a17:90a:7f91:b0:273:f887:be17 with SMTP id m17-20020a17090a7f9100b00273f887be17mr6929040pjl.47.1694734236251;
        Thu, 14 Sep 2023 16:30:36 -0700 (PDT)
Received: from ghost ([50.168.177.76])
        by smtp.gmail.com with ESMTPSA id w7-20020a17090a460700b002746d2a54fesm1713196pjg.8.2023.09.14.16.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 16:30:35 -0700 (PDT)
Date:   Thu, 14 Sep 2023 19:30:30 -0400
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v4 2/5] riscv: Add checksum library
Message-ID: <ZQOXlsCeA92mVSK9@ghost>
References: <20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com>
 <20230911-optimize_checksum-v4-2-77cc2ad9e9d7@rivosinc.com>
 <20230914-mural-deskbound-0e37d0767f6f@wendy>
 <ZQNJ0LQhZyJWlcSy@ghost>
 <20230914-thinness-overtly-70c49b219c26@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-thinness-overtly-70c49b219c26@spud>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 07:02:29PM +0100, Conor Dooley wrote:
> > > > +#ifndef CONFIG_32BIT
> > > 
> > > These can also be moved to IS_ENABLED() FYI, since there's no 32-bit
> > > stuff here that'd break the build for 64-bit. Ditto elsewhere where
> > > you've got similar stuff.
> > > 
> > > Cheers,
> > > Conor.
> > This is an ifndef, so 32-bit compilation would throw a warning about
> > shifting by 32 bits if IS_ENABLED was used instead.
> 
>  Fair enough. I did accidentally invert things in my mail, I did notice
>  the n, I just thought it did the elimination beforehand those checks,
>  sorry for the noise.

It appears that LLVM is smart enough to not attempt to compile code that
will never execute but GCC is not. Pretty interesting because it allows the
".option arch" code to be encased in IS_ENABLED because it is only not
supported on LLVM, but the shifting code needs to be in ifdef because
otherwise gcc will complain.

