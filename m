Return-Path: <linux-kernel+bounces-88834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0735186E753
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9858728DADD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B834125CB;
	Fri,  1 Mar 2024 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Eyz3nZP0"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9854CF9D7
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314229; cv=none; b=BpRz51CHY6bVNl1YDcbYv4Q7C8ickF90gyTeM3aTDitQ1COEBagCGNu2n+M9a+lj4H1iggZHpNIrZ8fXTtPa3ubu06CkwQ9BsG66MdZOg+hmFg4jFcFaYl/f670vEEkLjOBSGvGpqjwKrD0iWm6Fmnjaowh0lB/P6WWgE45K5LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314229; c=relaxed/simple;
	bh=ORpLEw2Dml0htr9PDhqhLA57rxjohRb0o0PDLtuEWfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMcUb05KHjeyE63M7jjwOmUuxbGWrdodQkP1WT35/dHOXsvd3gVz1HOc/zAKP1D9TLDaAjLxYTV3EX1a+Nc4eHuk1DnyIiOU2v7ytfnNjd18e82nq4cmYv1uf7V/MbvPh259J7gj7DMBQ/HinNNSVi+4Y6ztEJQGarjZ/6DjHI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Eyz3nZP0; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e56a5b2812so1583701b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 09:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709314227; x=1709919027; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UD7pU/mT2bb+4Cmi3ewKbhC8HoIrfKGME5sdau3RcUE=;
        b=Eyz3nZP0pDzuhv8XC6W75sE9+itGb007xOeLROAHa6yHadSReb+nSqTmz2aFDZIuCN
         Uxots+68N+njP5SHKm53AgA9x9MBHm8CuUpvWiTEQoqR7usWUAVEv1rfP5itRq/9YX4F
         JZkuzUfVk67G7mkf8905cEgB/D+ZKiDrmuKVuchF7E+z9L/9I8lBHe2uL4obfhy4hKw6
         FccR1voMndOZDXVJMqbRuhF9/Wpyj1sRfYI3G58zM2Ld8BadiSZWyRnhr5tWr0ovamSq
         VJNoBcRR/BHameAAHn9VjsGmQi4IBS1Wppc2PSYi8tOe4MHXYtREf8/BQv8ZS1Dm8t9m
         /6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709314227; x=1709919027;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UD7pU/mT2bb+4Cmi3ewKbhC8HoIrfKGME5sdau3RcUE=;
        b=WHE1tcI47lbCX4gmITScXpwxkYiE4eqoBd7YknE4CVxtD6v53VOGhvm6GA3SZbmFvu
         NMaUidI0nNqSZSQ+DrRy/5ZxvTSehbu5exijznSId6U3+0J+9dbryhodvNbJbXW1mUEh
         gVUuivz5ysJpALU95QL1fLhhmzQozPNA7pHvNYwMS6lH3wZikP8vjdlJXKkrMHJfSWc9
         155i+2LHJ++66j78Qqk0XO7hc9q4Oa+WrbO3IGPaBqJm8QJmMhsKxV1rpypMVhD3JOsj
         l661y8Q8KAqSx+gxKq3VIx2lwmtbeaukPP8EvhL5WqATQvardddR1yt5LNs/MflVgZpQ
         MFBg==
X-Forwarded-Encrypted: i=1; AJvYcCX6YQQ5JLSrt05gQrAYr3m4uRXi4lK5hQju6rag8RxsPe/G3RtxGgseT3HEYHurFGvCQ4igp4QgY7Mjq+Mp/4TLTkK5E8izlFbw14zM
X-Gm-Message-State: AOJu0Yx62r+HpXIVuH9HVRNazEEeZKKSij52X5edmbbyaI6CDDtilTGV
	reoM6LMyQsnL+PubjjHogf/BoX6dv2CYAkxj6cFF9NxjpD8+obvbYwZXoW4Hkck=
X-Google-Smtp-Source: AGHT+IHRAjmqQhV6njtbvelkZP08z5IbrdiljIAzhjSqP9o/OiaKYeQb6dzbZYimmaJlB0BUs7qVOQ==
X-Received: by 2002:a05:6a00:8611:b0:6e5:db1b:27cd with SMTP id hg17-20020a056a00861100b006e5db1b27cdmr524539pfb.6.1709314225954;
        Fri, 01 Mar 2024 09:30:25 -0800 (PST)
Received: from ghost ([2601:647:5700:6860:2a1e:5647:311:1139])
        by smtp.gmail.com with ESMTPSA id g24-20020a62e318000000b006e571bef670sm3214689pfh.70.2024.03.01.09.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:30:25 -0800 (PST)
Date: Fri, 1 Mar 2024 09:30:23 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: David Laight <David.Laight@aculab.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Guenter Roeck <linux@roeck-us.net>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Helge Deller <deller@gmx.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Parisc List <linux-parisc@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Russell King <linux@armlinux.org.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v11] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Message-ID: <ZeIQr3JWoly4JraV@ghost>
References: <20240229-fix_sparse_errors_checksum_tests-v11-1-f608d9ec7574@rivosinc.com>
 <41a5d1e8-6f30-4907-ba63-8a7526e71e04@csgroup.eu>
 <ZeILu9x+/STqWVy+@ghost>
 <3e0e2b25ea2d4ab99e78aff04af94b69@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e0e2b25ea2d4ab99e78aff04af94b69@AcuMS.aculab.com>

On Fri, Mar 01, 2024 at 05:24:39PM +0000, David Laight wrote:
> From: Charlie Jenkins
> > Sent: 01 March 2024 17:09
> > 
> > On Fri, Mar 01, 2024 at 07:17:38AM +0000, Christophe Leroy wrote:
> > > +CC netdev ARM Russell
> > >
> > > Le 29/02/2024 à 23:46, Charlie Jenkins a écrit :
> > > > The test cases for ip_fast_csum and csum_ipv6_magic were not properly
> > > > aligning the IP header, which were causing failures on architectures
> > > > that do not support misaligned accesses like some ARM platforms. To
> > > > solve this, align the data along (14 + NET_IP_ALIGN) bytes which is the
> > > > standard alignment of an IP header and must be supported by the
> > > > architecture.
> > >
> > > In your description, please provide more details on platforms that have
> > > a problem, what the problem is exactly (Failed calculation, slowliness,
> > > kernel Oops, panic, ....) on each platform.
> > >
> > > And please copy maintainers and lists of platforms your are specifically
> > > addressing with this change. And as this is network related, netdev list
> > > should have been copied as well.
> > >
> > > I still think that your patch is not the good approach, it looks like
> > > you are ignoring all the discussion. Below is a quote of what Geert said
> > > and I fully agree with that:
> > >
> > > 	IMHO the tests should validate the expected functionality.  If a test
> > > 	fails, either functionality is missing or behaves wrong, or the test
> > > 	is wrong.
> > >
> > > 	What is the point of writing tests for a core functionality like network
> > > 	checksumming that do not match the expected functionality?
> > >
> > >
> > > So we all agree that there is something to fix, because today's test
> > > does odd-address accesses which is unexpected for those functions, but
> > > 2-byte alignments should be supported hence tested by the test. Limiting
> > > the test to a 16-bytes alignment deeply reduces the usefullness of the test.
> > >
> > 
> > Maybe I am lost in the conversations. This isn't limited to 16-bytes
> > alignment? It aligns along 14 + NET_IP_ALIGN. That is 16 on some
> > platforms and 14 on platforms where unaligned accesses are desired.
> > These functions are expected to be called with this offset. Testing with
> > any other alignment is not the expected behavior. These tests are
> > testing the expected functionality.
> 
> Aligned received frames can have a 4 byte VLAN header (or two) removed.
> So the alignment of the IP header is either 4n or 4n+2.
> If the cpu fault misaligned accesses you really want the alignment
> to be 4n.
> 
> You pretty much never want to trap and fixup a misaligned access.
> Especially in the network stack.
> I suspect it is better to do a realignment copy of the entire frame.
> At some point the data will be copied again, although you may want
> a CBU (crystal ball unit) to decide whether to align on an 8n
> or 8n+4 boundary to optimise a later copy.
> 
> CPU that support misaligned transfers just make coders sloppy :-)
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

Can you elaborate on how exactly you suggest the tests to be changed to
accomidate what you are saying here? I don't understand how what I have
proposed doesn't represent the use case of these functions.

- Charlie


