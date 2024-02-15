Return-Path: <linux-kernel+bounces-67202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E168567F9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E201C237C7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022DF133421;
	Thu, 15 Feb 2024 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2oLpDIOZ"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEF313398D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011392; cv=none; b=GQZzwN+dhHrfHy0FG5ZvzSB0Nj+gNGg5rcNH9nbQZVc0C5QArhUZkLJb+pljTBnxB0/HRzKRmlyA7xGB+inv4QKJp00HliVxcILnkS+NfPa163xBUPOCEFbIanTjd7i0bZf1fzPJI/VH6SBT0gXHuxA+YHf+fUOA8tfOpnP5TXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011392; c=relaxed/simple;
	bh=SHOsohQCVk8Mi+NNdj2jfOKDNAp69jy2VOPdCJJt+q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQRVqLs/Ocvn4YKtJ1k60KAC1HfMgJaelQhWLhQgz0bWO7TSw0T4bGcnhdQBlklLmRNWIK90e2SslrFssGb8fpBPeJIXSJ3D1V7If8yB5gEsKbG+3YDKXroZf2k7TlXHc+dQwKHqwkPrPQX4Akb0bip2vJaOYREJJRJJyZS5NcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2oLpDIOZ; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso1013127276.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 07:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708011388; x=1708616188; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3pd5Z9bCkRZAvWYNH8OwXvr8NmpG4s7j8kTUQAlhIF4=;
        b=2oLpDIOZey5aXGIFeJU/a8LsbfzBerJdeFKtvnkiI2NcCSfwLCvF6Go4QOctBC1Xhp
         C2i/KFFD2BsLDAuJLcVSntfVAiSinwyiBJBvqiljxbL5O5FB7Ew/HXd++dIyCBwqs5rW
         y/Zrwd3EBkrir7ZT8yAbbn1HNnlYRRifI4T6iqtoBAvYWVfGI452pOdpDyzEImABRzGm
         DTKDMJZgSHxU2Xb9r7A/+grrL+MMa8hyseazQjGNtozONBSx0f+Plme/M0iv42090UHm
         5b9Ltedlv8Ba54ABuuzIvG0eMWluPTtEgBTN+vMlqg0eEgHtPh4Y39JHdgSQH9/Fv0uV
         R+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708011388; x=1708616188;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3pd5Z9bCkRZAvWYNH8OwXvr8NmpG4s7j8kTUQAlhIF4=;
        b=Kgp/Tan3ry0zCChnfTHtOkqkQEWG1Z39kdQSwWJds2+pfKyxkXuoAs8IrTy3q2L3fe
         JWtIn6jihQuljUOYFDYmO81uNYiVOsM14uib0zVQiIpk12z3YqJjaA9v9qMduXJJhUst
         WRYcztF3DIEcTA9NpFFk4IY7TsrPz+Gq+obWF6L/GOrR1RrZ/aubJoheRPKl5PAZLMO4
         e5MHjoqR12+Wshn43LpU3ymHNv0Nk4EaJxn2LVqmofLJzNdNRgYusjwuQf7+0wocal9F
         iCTS5aQ7b1W8n7SFqVZAviaxScMORxU8hnnurjUTDufbDhFzp9l5GngHN+OvTxUiAYfN
         7o7g==
X-Forwarded-Encrypted: i=1; AJvYcCXPV5TEMkG6KBW2PddKAlGEjYBnhBcT/RiVit/RXb82qZgdZqqJC79bYHmWBZdt2WBUFniwfyP0tde4ZzY9rmNZLdgvMjPGrkMfkW4/
X-Gm-Message-State: AOJu0YywmrKi9nIzFFRjJv17zIl5T/c0BJBL7phx0+/w0KcGqLUkr6/C
	hSsKR8TmbBRvGt/bP04wQ2r6hQYJFcBWJr6EOOeqDZQ5Sk4jpd30SJ1YK8opKZU=
X-Google-Smtp-Source: AGHT+IG6vRmSD1zRYeD4ymw86uKgfET3PGueEePIwXpcqRD4LLeLf4tbUBRqs/U4ycSYhu5gSVFJTw==
X-Received: by 2002:a25:84cd:0:b0:dbd:5bfa:9681 with SMTP id x13-20020a2584cd000000b00dbd5bfa9681mr1648224ybm.37.1708011387748;
        Thu, 15 Feb 2024 07:36:27 -0800 (PST)
Received: from ghost ([50.146.0.2])
        by smtp.gmail.com with ESMTPSA id i15-20020a056902068f00b00dc73705ec59sm218316ybt.0.2024.02.15.07.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 07:36:27 -0800 (PST)
Date: Thu, 15 Feb 2024 10:36:25 -0500
From: Charlie Jenkins <charlie@rivosinc.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: John David Anglin <dave.anglin@bell.net>,
	David Laight <David.Laight@aculab.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Helge Deller <deller@gmx.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Parisc List <linux-parisc@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Message-ID: <Zc4veRSmxHHqu/bB@ghost>
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
 <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net>
 <Zc1pSi59aDOnqz++@ghost>
 <cb4e358b-3fd0-4ca4-bf53-9cc379087304@roeck-us.net>
 <1d5e059e-5b31-415d-ae41-593415812e94@bell.net>
 <Zc2GfgiCpevtKTtS@ghost>
 <11fff7fe-ec4c-4340-a67f-d1d54d0712d8@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11fff7fe-ec4c-4340-a67f-d1d54d0712d8@roeck-us.net>

On Thu, Feb 15, 2024 at 12:56:13AM -0800, Guenter Roeck wrote:
> On 2/14/24 19:35, Charlie Jenkins wrote:
> > On Wed, Feb 14, 2024 at 10:00:37PM -0500, John David Anglin wrote:
> > > On 2024-02-14 8:58 p.m., Guenter Roeck wrote:
> > > > Specifically: Yes, the carry/borrow bits should be restored. Question is
> > > > if the Linux kernel's interrupt handler doesn't restore the carry bits
> > > > or if the problem is on the qemu side.
> > > The carry/borrow bits in the PSW should be saved and restored by the save_specials
> > > and rest_specials macros.  They are defined in arch/parisc/include/asm/assembly.h.
> > 
> > Why would they be needed to be restored in linux? The manual says "The
> > PSW is set to the contents of the IPSW by the RETURN FROM INTERRUPTION
> > instruction". This means that the PSW must be restored by the hardware.
> > 
> > We can see the QEMU implementation in:
> > 
> > rfi:
> > https://github.com/qemu/qemu/blob/v8.2.1/target/hppa/sys_helper.c#L93
> > 
> > handling interrupt:
> > https://github.com/qemu/qemu/blob/v8.2.1/target/hppa/int_helper.c#L109
> > 
> > However the implementation appears to be faulty. During an RFI, the PSW
> > is always set to 0x804000e (regardless of what the PSW was before the
> > interrupt).
> > 
> 
> Not sure if I agree. The interrupt handler in Linux is the one which needs to set
> IPSW. Looking into the code, I agree with Dave that the tophys macro seems to
> clobber the carry bits before psw is saved, so they can not really be restored.
> The only issue with that idea is that I can only reproduce the problem with
> an interrupted ldd instruction but not, for example, with ldw. This is why it
> would be really important to have someone with real hardware test this.
> 
> Thanks,
> Guenter

Yes, we definitely feedback from somebody with access to hardware, but I
do not understand how "The PSW is set to the contents of the IPSW by the
RETURN FROM INTERRUPTION" could be interpreted as anything except that
the hardware is expected to over-write the contents of the PSW during
the rfi.

- Charlie

> 

