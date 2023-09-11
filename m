Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9E579C0ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354730AbjIKVzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243902AbjIKSQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:16:57 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC562110
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 11:16:49 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bc0d39b52cso34354085ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 11:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694456209; x=1695061009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MjhADH8UGjZeZbL1DxQMJ3F6ebKKJi8760M3qyFc/vM=;
        b=jL2NZxKd/wVwlFmTxYDCH3xvLfdwf8jbXxPBNU1+uY7opYAESjyirZ4JvfHIBT6vxU
         uJ78dEU+IFcWztwL2fOriQREnJfOPT+8IVLkcbX6gIG92dbsCwzqKgyjUWjECKDgcTFa
         kqxqkWjK4w2KT4ht4xxymJS8URFMhMrwAJXxVysrTchXcCoXJ48+VAw6pqLa8aWy701O
         HdmF2jo3kqB1Z3ozskkHkUmDEJY4VwNhgc4Jn4RYaVjsaN4AwepYhJtS9F+Rm/FKxZ5S
         HmSJzhgDWd2oY4mHdEgrbc3UhF+wbRrygDMmPSXsu0lpV+0UYiPo09ecu+Hp61I7Xg+M
         rDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694456209; x=1695061009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjhADH8UGjZeZbL1DxQMJ3F6ebKKJi8760M3qyFc/vM=;
        b=th2WIP3bUY0s6ijpVRPvYw5em/Rv7CQc0qMeVqFt0Y/r4pQ3mJkTwvaXsj2BHkm8lR
         Mudf2bFaNQjAuWkPcfDDIFm3Wd99gKYK4xFwDoRHULN2O3hJBsMoNxFyIK7URJPdT077
         X+wwRF0iNBlRvK4mMyPED0KLs6N37UjutXJHOGXoZ0/OycIpPA28w+gL/0l2exLykn6Q
         bnTcz0/ElmrTA6VLgJY+o8+3sqangGyP2wEeBJFTDdyRXf/bv/j3m/2RnvjKk/fWRsYr
         pq/FBI0WNu9KVh1yQmdAzIYwf4alGm1Cg5vviuMHjCbSfE0qUFhExYcKPiNoG+44BJQa
         Isug==
X-Gm-Message-State: AOJu0YyZf6HvjmYVUty/5Bb7Y+buK6W/JxkgeE+2gmT00eavvUaou+QY
        x6gMun6U1FSFpktbS4yf02B3pg==
X-Google-Smtp-Source: AGHT+IGE+2fPDidDBevqz3qxmsZScDGIrIOCV+tWsA4RlmlOOJ4PFSPK+bB/IOz42cL74l+xTtgS8A==
X-Received: by 2002:a17:902:e889:b0:1c3:aef9:872e with SMTP id w9-20020a170902e88900b001c3aef9872emr3984841plg.34.1694456209177;
        Mon, 11 Sep 2023 11:16:49 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:53c6:e395:693d:402a])
        by smtp.gmail.com with ESMTPSA id g2-20020a1709026b4200b001b8a00d4f7asm6750332plt.9.2023.09.11.11.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 11:16:48 -0700 (PDT)
Date:   Mon, 11 Sep 2023 11:16:46 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2 1/5] riscv: Checksum header
Message-ID: <ZP9ZjoFk1GV8gcW1@ghost>
References: <20230905-optimize_checksum-v2-0-ccd658db743b@rivosinc.com>
 <20230905-optimize_checksum-v2-1-ccd658db743b@rivosinc.com>
 <20230907-f8c8993dbeb24d5ea5310ec7@fedora>
 <ZPoMAGYlIxPZsE7+@ghost>
 <cec0f23506a54b9aaaef054ea949e4aa@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cec0f23506a54b9aaaef054ea949e4aa@AcuMS.aculab.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2023 at 09:20:33PM +0000, David Laight wrote:
> ...
> > > > +/*
> > > > + *	Fold a partial checksum without adding pseudo headers
> > > > + */
> > > > +static inline __sum16 csum_fold(__wsum sum)
> > > > +{
> > > > +	sum += (sum >> 16) | (sum << 16);
> > > > +	return (__force __sum16)(~(sum >> 16));
> > > > +}
> 
> I'm intrigued, gcc normally compiler that quite well.
> The very similar (from arch/arc):
> 	return (~sum - rol32(sum, 16)) >> 16;
> is slightly better on most architectures.
> (Especially if the ~sum and rol() can be executed together.)
Oh wow that solves the problem of needing to zero extend the result
after taking the not. Taking the shift after the not both zero-extends
and places the result in the correct spot. It is a very interesting
property that it is possible to change the order of the operations if
the addition becomes a subtraction. I will make the change. Thank you!

- Charlie
> 
> The only odd archs I saw were sparc32 (carry flag bug no rotate)
> and arm (barrel shifter on all instructions).
> 
> It is better than the current asm for a lot of archs including x64.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
