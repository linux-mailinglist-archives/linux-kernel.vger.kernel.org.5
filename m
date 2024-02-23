Return-Path: <linux-kernel+bounces-77824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F80E860AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7721B21D55
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727F9125AD;
	Fri, 23 Feb 2024 06:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="u2w8jJEM"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084D511C84
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708668774; cv=none; b=AOaB1dbJeVtyh8fxAYZPHixJYCnmQ5YxU8xNVY39tYedPkdKNHUnM7CCrGhSttO7Nh1EYVTZMeX/tBfstSQKStioE0xkgT7kb8fbpc2ffty0QBTxr7GttDaMZBZw3D0xm/xVpMybB9X5HC9URajjEJ9ymwuWRqCNMK1BhiIfASo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708668774; c=relaxed/simple;
	bh=rx1X9MVNJkw8Z5WA6XuWmxNNZLKYcN0mtaczFWbxdpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aS/z1LrnnC0ms4PP96PBHmdqinxI0JrMCRSwd5do3GInAIbHVWPwMsa0DJGzfVzEXJeB/s30ssFj5RobMI4Vt6nNchGrYsdiHyXE7Y6lscUmXac1HqMUbDXT3LNpGfuuOEgCCyX9QTB/GdTbxyyuXHMJNBFa1IdvvaZFyIiqLRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=u2w8jJEM; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbbc6e51d0so332152b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708668771; x=1709273571; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6+FJvkA+NVSkLGrEb3ooS7zHjJgxV3a59zcKf7gWnfU=;
        b=u2w8jJEMu2H+PKMFxtJJMMN+SreKDJScqvtRv0iiG6ve77xDF35Qm7sTf+nN1/ikDi
         aMz2sOXq4CIhDw49hP2nZH515CdYxKUNNDRJSJMt6b+pLGRMDm4iK9JpZDK8LxTVT2Ul
         snowo3p5OTmzFTqRbFXbxdIh9R02Q/RYX9VMXfCrKoUOyz3+IuA4yiGExRU2u0XuvbEc
         Fy3x74+cbSOGAHQz8kPTowd4dgyxzVAr3jox+M36jOmRw6raBuoLDuZYStBvF9fCL1xY
         ikJRBSJYcd6f3kTeq1cN06HYSkpCUFG/8JvzZiVZ2y8bzPTOvrtr+Lsx+fXoPPcS5P3I
         0eZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708668771; x=1709273571;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+FJvkA+NVSkLGrEb3ooS7zHjJgxV3a59zcKf7gWnfU=;
        b=TZ3Q4gNWXmWim+FHV6Vlz8PMW7KctKV/ypUWzTHVTjcb2vCcJ0BtEYljpeu4N0Hn1w
         DE8va+6kvfr3Ygz6KZNi9QLJ3xjyYfykMZcDlKU0QOArY5UzZlfQwvbzXMk0Ar3coRCt
         N/IopgRhPqxLPLhbBMv1MpvVyNFXVb66vHN690X+lJBX5jt8ma1F8oth448M0gFfveSC
         yUf0A+33zTY9bxwwZbwl78C/c0xwel3/13map4nFDwdEJ/eMDDFCARpt0ISq5HCNHS6W
         NcAlKcPAi6HR+pXsdvMOnic/wsun6NK2gO9h5hXd+SwfCVqpoIwx15WsUyIv3t7nzJet
         dd5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOeusgwr7JKT0HKmt05t3/kdOm6hRhjemIxHpp5qvdlOTpLSlvnj93YojMwq5UE5sUGsncWEl+2YesUswDMX9k0PsQTzsoCWWtkfzM
X-Gm-Message-State: AOJu0YyGp7FfYII2hzPchVlhsNKlKmKI4k821VGaXwhXWMZXUg+74Eh+
	/2DRB4eZTkjA6h84OlHeA6j/1yFdL8Q0eGZ1S9Jhbon+kRuIRU+YjhJRuWOK2EM=
X-Google-Smtp-Source: AGHT+IHUtkjy8HubvTxCVo97IUEI7MplXA9430ueGwfeXj+aUWemSwJjYDBA6cZQ6qiESsI8IKp2Og==
X-Received: by 2002:a05:6358:340b:b0:17b:6391:1136 with SMTP id h11-20020a056358340b00b0017b63911136mr903683rwd.17.1708668770829;
        Thu, 22 Feb 2024 22:12:50 -0800 (PST)
Received: from ghost ([2601:647:5700:6860:aede:c20c:3775:da4a])
        by smtp.gmail.com with ESMTPSA id s27-20020a056a00179b00b006e3cdae7e60sm10494407pfg.58.2024.02.22.22.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 22:12:50 -0800 (PST)
Date: Thu, 22 Feb 2024 22:12:47 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Erhard Furtner <erhard_f@mailbox.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: "test_ip_fast_csum: ASSERTION FAILED at
 lib/checksum_kunit.c:589" at boot with CONFIG_CHECKSUM_KUNIT=y enabled on a
 Talos II, kernel 6.8-rc5
Message-ID: <Zdg3X4A1eJsJ+ACh@ghost>
References: <20240223022654.625bef62@yea>
 <528c6abf-e5ef-42cd-a5d7-6ede3254523d@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <528c6abf-e5ef-42cd-a5d7-6ede3254523d@csgroup.eu>

On Fri, Feb 23, 2024 at 05:59:07AM +0000, Christophe Leroy wrote:
> Hi Erhard, hi Charlie,
> 
> Le 23/02/2024 à 02:26, Erhard Furtner a écrit :
> > Greetings!
> > 
> > Looks like my Talos II (running a BE kernel+system) fails some of the kernels internal unit tests. One of the failing tests is checksum_kunit, enabled via CONFIG_CHECKSUM_KUNIT=y:
> > 
> > [...]
> >     KTAP version 1
> >      # Subtest: checksum
> >      # module: checksum_kunit
> >      1..5
> > entry-flush: disabled on command line.
> >      ok 1 test_csum_fixed_random_inputs
> >      ok 2 test_csum_all_carry_inputs
> >      ok 3 test_csum_no_carry_inputs
> >      # test_ip_fast_csum: ASSERTION FAILED at lib/checksum_kunit.c:589
> >      Expected ( u64)expected == ( u64)csum_result, but
> >          ( u64)expected == 55939 (0xda83)
> >          ( u64)csum_result == 33754 (0x83da)
> >      not ok 4 test_ip_fast_csum
> >      # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:617
> >      Expected ( u64)expected_csum_ipv6_magic[i] == ( u64)csum_ipv6_magic(saddr, daddr, len, proto, csum), but
> >          ( u64)expected_csum_ipv6_magic[i] == 6356 (0x18d4)
> >          ( u64)csum_ipv6_magic(saddr, daddr, len, proto, csum) == 43586 (0xaa42)
> >      not ok 5 test_csum_ipv6_magic
> > # checksum: pass:3 fail:2 skip:0 total:5
> > # Totals: pass:3 fail:2 skip:0 total:5
> > not ok 4 checksum
> > [...]
> > 
> > Full dmesg + kernel .config attached.
> 
> Looks like the same problem as the one I fixed with commit b38460bc463c 
> ("kunit: Fix checksum tests on big endian CPUs")
> 
> The new tests implemented through commit 6f4c45cbcb00 ("kunit: Add tests 
> for csum_ipv6_magic and ip_fast_csum") create a lot of type issues as 
> reported by sparse when built with C=2 (see below).
> 
> Once those issues are fixed, it should work.
> 
> Charlie, can you provide a fix ?
> 
> Thanks,
> Christophe

The "lib: checksum: Fix issues with checksum tests" patch should fix all of these issues [1].

[1] https://lore.kernel.org/all/20240221-fix_sparse_errors_checksum_tests-v9-1-bff4d73ab9d1@rivosinc.com/T/#m189783a9b2a7d12e3c34c4a412e65408658db2c9

- Charlie

> 
>    CC      lib/checksum_kunit.o
>    CHECK   lib/checksum_kunit.c
> lib/checksum_kunit.c:219:9: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:219:9:    expected restricted __sum16
> lib/checksum_kunit.c:219:9:    got int
> lib/checksum_kunit.c:219:17: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:219:17:    expected restricted __sum16
> lib/checksum_kunit.c:219:17:    got int
> lib/checksum_kunit.c:219:25: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:219:25:    expected restricted __sum16
> lib/checksum_kunit.c:219:25:    got int
> lib/checksum_kunit.c:219:33: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:219:33:    expected restricted __sum16
> lib/checksum_kunit.c:219:33:    got int
> lib/checksum_kunit.c:219:41: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:219:41:    expected restricted __sum16
> lib/checksum_kunit.c:219:41:    got int
> lib/checksum_kunit.c:219:49: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:219:49:    expected restricted __sum16
> lib/checksum_kunit.c:219:49:    got int
> lib/checksum_kunit.c:219:57: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:219:57:    expected restricted __sum16
> lib/checksum_kunit.c:219:57:    got int
> lib/checksum_kunit.c:219:65: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:219:65:    expected restricted __sum16
> lib/checksum_kunit.c:219:65:    got int
> lib/checksum_kunit.c:219:73: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:219:73:    expected restricted __sum16
> lib/checksum_kunit.c:219:73:    got int
> lib/checksum_kunit.c:220:9: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:220:9:    expected restricted __sum16
> lib/checksum_kunit.c:220:9:    got int
> lib/checksum_kunit.c:220:17: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:220:17:    expected restricted __sum16
> lib/checksum_kunit.c:220:17:    got int
> lib/checksum_kunit.c:220:25: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:220:25:    expected restricted __sum16
> lib/checksum_kunit.c:220:25:    got int
> lib/checksum_kunit.c:220:33: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:220:33:    expected restricted __sum16
> lib/checksum_kunit.c:220:33:    got int
> lib/checksum_kunit.c:220:41: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:220:41:    expected restricted __sum16
> lib/checksum_kunit.c:220:41:    got int
> lib/checksum_kunit.c:220:49: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:220:49:    expected restricted __sum16
> lib/checksum_kunit.c:220:49:    got int
> lib/checksum_kunit.c:220:57: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:220:57:    expected restricted __sum16
> lib/checksum_kunit.c:220:57:    got int
> lib/checksum_kunit.c:220:65: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:220:65:    expected restricted __sum16
> lib/checksum_kunit.c:220:65:    got int
> lib/checksum_kunit.c:220:73: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:220:73:    expected restricted __sum16
> lib/checksum_kunit.c:220:73:    got int
> lib/checksum_kunit.c:221:9: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:221:9:    expected restricted __sum16
> lib/checksum_kunit.c:221:9:    got int
> lib/checksum_kunit.c:221:17: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:221:17:    expected restricted __sum16
> lib/checksum_kunit.c:221:17:    got int
> lib/checksum_kunit.c:221:25: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:221:25:    expected restricted __sum16
> lib/checksum_kunit.c:221:25:    got int
> lib/checksum_kunit.c:221:33: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:221:33:    expected restricted __sum16
> lib/checksum_kunit.c:221:33:    got int
> lib/checksum_kunit.c:221:41: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:221:41:    expected restricted __sum16
> lib/checksum_kunit.c:221:41:    got int
> lib/checksum_kunit.c:221:49: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:221:49:    expected restricted __sum16
> lib/checksum_kunit.c:221:49:    got int
> lib/checksum_kunit.c:221:57: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:221:57:    expected restricted __sum16
> lib/checksum_kunit.c:221:57:    got int
> lib/checksum_kunit.c:221:65: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:221:65:    expected restricted __sum16
> lib/checksum_kunit.c:221:65:    got int
> lib/checksum_kunit.c:221:73: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:221:73:    expected restricted __sum16
> lib/checksum_kunit.c:221:73:    got int
> lib/checksum_kunit.c:222:9: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:222:9:    expected restricted __sum16
> lib/checksum_kunit.c:222:9:    got int
> lib/checksum_kunit.c:222:17: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:222:17:    expected restricted __sum16
> lib/checksum_kunit.c:222:17:    got int
> lib/checksum_kunit.c:222:25: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:222:25:    expected restricted __sum16
> lib/checksum_kunit.c:222:25:    got int
> lib/checksum_kunit.c:222:33: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:222:33:    expected restricted __sum16
> lib/checksum_kunit.c:222:33:    got int
> lib/checksum_kunit.c:222:41: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:222:41:    expected restricted __sum16
> lib/checksum_kunit.c:222:41:    got int
> lib/checksum_kunit.c:222:49: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:222:49:    expected restricted __sum16
> lib/checksum_kunit.c:222:49:    got int
> lib/checksum_kunit.c:222:57: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:222:57:    expected restricted __sum16
> lib/checksum_kunit.c:222:57:    got int
> lib/checksum_kunit.c:222:65: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:222:65:    expected restricted __sum16
> lib/checksum_kunit.c:222:65:    got int
> lib/checksum_kunit.c:222:73: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:222:73:    expected restricted __sum16
> lib/checksum_kunit.c:222:73:    got int
> lib/checksum_kunit.c:223:9: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:223:9:    expected restricted __sum16
> lib/checksum_kunit.c:223:9:    got int
> lib/checksum_kunit.c:223:17: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:223:17:    expected restricted __sum16
> lib/checksum_kunit.c:223:17:    got int
> lib/checksum_kunit.c:223:25: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:223:25:    expected restricted __sum16
> lib/checksum_kunit.c:223:25:    got int
> lib/checksum_kunit.c:223:33: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:223:33:    expected restricted __sum16
> lib/checksum_kunit.c:223:33:    got int
> lib/checksum_kunit.c:223:41: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:223:41:    expected restricted __sum16
> lib/checksum_kunit.c:223:41:    got int
> lib/checksum_kunit.c:223:49: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:223:49:    expected restricted __sum16
> lib/checksum_kunit.c:223:49:    got int
> lib/checksum_kunit.c:223:57: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:223:57:    expected restricted __sum16
> lib/checksum_kunit.c:223:57:    got int
> lib/checksum_kunit.c:223:65: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:223:65:    expected restricted __sum16
> lib/checksum_kunit.c:223:65:    got int
> lib/checksum_kunit.c:223:73: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:223:73:    expected restricted __sum16
> lib/checksum_kunit.c:223:73:    got int
> lib/checksum_kunit.c:224:9: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:224:9:    expected restricted __sum16
> lib/checksum_kunit.c:224:9:    got int
> lib/checksum_kunit.c:224:17: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:224:17:    expected restricted __sum16
> lib/checksum_kunit.c:224:17:    got int
> lib/checksum_kunit.c:224:25: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:224:25:    expected restricted __sum16
> lib/checksum_kunit.c:224:25:    got int
> lib/checksum_kunit.c:224:33: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:224:33:    expected restricted __sum16
> lib/checksum_kunit.c:224:33:    got int
> lib/checksum_kunit.c:224:41: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:224:41:    expected restricted __sum16
> lib/checksum_kunit.c:224:41:    got int
> lib/checksum_kunit.c:224:49: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:224:49:    expected restricted __sum16
> lib/checksum_kunit.c:224:49:    got int
> lib/checksum_kunit.c:224:57: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:224:57:    expected restricted __sum16
> lib/checksum_kunit.c:224:57:    got int
> lib/checksum_kunit.c:224:65: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:224:65:    expected restricted __sum16
> lib/checksum_kunit.c:224:65:    got int
> lib/checksum_kunit.c:224:73: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:224:73:    expected restricted __sum16
> lib/checksum_kunit.c:224:73:    got int
> lib/checksum_kunit.c:225:9: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:225:9:    expected restricted __sum16
> lib/checksum_kunit.c:225:9:    got int
> lib/checksum_kunit.c:225:17: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:225:17:    expected restricted __sum16
> lib/checksum_kunit.c:225:17:    got int
> lib/checksum_kunit.c:225:25: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:225:25:    expected restricted __sum16
> lib/checksum_kunit.c:225:25:    got int
> lib/checksum_kunit.c:225:33: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:225:33:    expected restricted __sum16
> lib/checksum_kunit.c:225:33:    got int
> lib/checksum_kunit.c:225:41: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:225:41:    expected restricted __sum16
> lib/checksum_kunit.c:225:41:    got int
> lib/checksum_kunit.c:225:49: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:225:49:    expected restricted __sum16
> lib/checksum_kunit.c:225:49:    got int
> lib/checksum_kunit.c:225:57: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:225:57:    expected restricted __sum16
> lib/checksum_kunit.c:225:57:    got int
> lib/checksum_kunit.c:225:65: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:225:65:    expected restricted __sum16
> lib/checksum_kunit.c:225:65:    got int
> lib/checksum_kunit.c:225:73: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:225:73:    expected restricted __sum16
> lib/checksum_kunit.c:225:73:    got int
> lib/checksum_kunit.c:226:9: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:226:9:    expected restricted __sum16
> lib/checksum_kunit.c:226:9:    got int
> lib/checksum_kunit.c:226:17: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:226:17:    expected restricted __sum16
> lib/checksum_kunit.c:226:17:    got int
> lib/checksum_kunit.c:226:25: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:226:25:    expected restricted __sum16
> lib/checksum_kunit.c:226:25:    got int
> lib/checksum_kunit.c:226:33: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:226:33:    expected restricted __sum16
> lib/checksum_kunit.c:226:33:    got int
> lib/checksum_kunit.c:226:41: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:226:41:    expected restricted __sum16
> lib/checksum_kunit.c:226:41:    got int
> lib/checksum_kunit.c:226:49: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:226:49:    expected restricted __sum16
> lib/checksum_kunit.c:226:49:    got int
> lib/checksum_kunit.c:226:57: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:226:57:    expected restricted __sum16
> lib/checksum_kunit.c:226:57:    got int
> lib/checksum_kunit.c:226:65: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:226:65:    expected restricted __sum16
> lib/checksum_kunit.c:226:65:    got int
> lib/checksum_kunit.c:226:73: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:226:73:    expected restricted __sum16
> lib/checksum_kunit.c:226:73:    got int
> lib/checksum_kunit.c:227:9: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:227:9:    expected restricted __sum16
> lib/checksum_kunit.c:227:9:    got int
> lib/checksum_kunit.c:227:17: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:227:17:    expected restricted __sum16
> lib/checksum_kunit.c:227:17:    got int
> lib/checksum_kunit.c:227:25: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:227:25:    expected restricted __sum16
> lib/checksum_kunit.c:227:25:    got int
> lib/checksum_kunit.c:227:33: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:227:33:    expected restricted __sum16
> lib/checksum_kunit.c:227:33:    got int
> lib/checksum_kunit.c:227:41: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:227:41:    expected restricted __sum16
> lib/checksum_kunit.c:227:41:    got int
> lib/checksum_kunit.c:227:49: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:227:49:    expected restricted __sum16
> lib/checksum_kunit.c:227:49:    got int
> lib/checksum_kunit.c:227:57: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:227:57:    expected restricted __sum16
> lib/checksum_kunit.c:227:57:    got int
> lib/checksum_kunit.c:227:65: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:227:65:    expected restricted __sum16
> lib/checksum_kunit.c:227:65:    got int
> lib/checksum_kunit.c:227:73: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:227:73:    expected restricted __sum16
> lib/checksum_kunit.c:227:73:    got int
> lib/checksum_kunit.c:228:9: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:228:9:    expected restricted __sum16
> lib/checksum_kunit.c:228:9:    got int
> lib/checksum_kunit.c:228:17: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:228:17:    expected restricted __sum16
> lib/checksum_kunit.c:228:17:    got int
> lib/checksum_kunit.c:228:25: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:228:25:    expected restricted __sum16
> lib/checksum_kunit.c:228:25:    got int
> lib/checksum_kunit.c:228:33: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:228:33:    expected restricted __sum16
> lib/checksum_kunit.c:228:33:    got int
> lib/checksum_kunit.c:228:41: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:228:41:    expected restricted __sum16
> lib/checksum_kunit.c:228:41:    got int
> lib/checksum_kunit.c:228:49: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:228:49:    expected restricted __sum16
> lib/checksum_kunit.c:228:49:    got int
> lib/checksum_kunit.c:228:57: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:228:57:    expected restricted __sum16
> lib/checksum_kunit.c:228:57:    got int
> lib/checksum_kunit.c:228:65: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:228:65:    expected restricted __sum16
> lib/checksum_kunit.c:228:65:    got int
> lib/checksum_kunit.c:228:73: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:228:73:    expected restricted __sum16
> lib/checksum_kunit.c:228:73:    got int
> lib/checksum_kunit.c:229:9: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:229:9:    expected restricted __sum16
> lib/checksum_kunit.c:229:9:    got int
> lib/checksum_kunit.c:229:17: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:229:17:    expected restricted __sum16
> lib/checksum_kunit.c:229:17:    got int
> lib/checksum_kunit.c:229:25: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:229:25:    expected restricted __sum16
> lib/checksum_kunit.c:229:25:    got int
> lib/checksum_kunit.c:229:33: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:229:33:    expected restricted __sum16
> lib/checksum_kunit.c:229:33:    got int
> lib/checksum_kunit.c:229:41: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:229:41:    expected restricted __sum16
> lib/checksum_kunit.c:229:41:    got int
> lib/checksum_kunit.c:229:49: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:229:49:    expected restricted __sum16
> lib/checksum_kunit.c:229:49:    got int
> lib/checksum_kunit.c:229:57: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:229:57:    expected restricted __sum16
> lib/checksum_kunit.c:229:57:    got int
> lib/checksum_kunit.c:229:65: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:229:65:    expected restricted __sum16
> lib/checksum_kunit.c:229:65:    got int
> lib/checksum_kunit.c:229:73: warning: incorrect type in initializer 
> (different base types)
> lib/checksum_kunit.c:229:73:    expected restricted __sum16
> lib/checksum_kunit.c:229:73:    got int
> lib/checksum_kunit.c:230:9: warning: too many warnings

