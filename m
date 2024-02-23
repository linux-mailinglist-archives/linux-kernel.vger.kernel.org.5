Return-Path: <linux-kernel+bounces-78046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEA3860E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18B41C22640
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA825C91A;
	Fri, 23 Feb 2024 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1XQKLyP"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8033D1B95F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681325; cv=none; b=lpwIz/7jtvDStcSy+aPEaNa//Sg3Edn6m9c2pwArj0xC89ngcturGKQPi7Amy/gSqhqqnMXm27Bo0vB7uo6Q+E/cV5lBj0bQSsvqr71+mJTd7EsriizazQx2jD5EUbJNCY+ELWfqSeV3HdfvbQbF9ZsLmS6bp/yS2oKRSV1pbKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681325; c=relaxed/simple;
	bh=tiLrttMRwT8vCIurOXRIlRgXCqpHySp2xPh+CqveHMU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=MOE145CJO5EwechufFTCa+Y9H1u7QyfdAXjV56rgkQDjXQLQZwoLbckwH6pJCdiVkU8jFKnu/ELzB8v8WfxEFf/QJ5jCyl1lJaivnIvEl5KmQO8pdSr/QvK8ILfmvYveWhtPa/Y4i2nO0EhINslWufwz2T95h0iXksZ/X+a/DeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q1XQKLyP; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d5cbc4a585so217808241.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708681322; x=1709286122; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5vxAQbq8EgE/2JJwOSWCuGz+rEc2pK5AZO+RpGD7vjU=;
        b=q1XQKLyPND1mFgll0YXMTuz6IUu2RfUbTv+hFspHk6/xgoHg8SWpaIN+hfplcg1aMz
         AsVihFh1r3fg/lDmKx1Y7tnFmqhj7ljZQPwO6Isr9ByY8jKSG0CdetCDHtefD4eleZA8
         X5IZ8hvo1GC6SWidW2o5kyMvPTAwi6nIQJ+WRW1YgrQaC/UaX1YYubb5gqpF6+joz87s
         ZNPcLYAXH1MT+aFZ4q62ozYPfOsCwIVS6sjrKXjkZJKSGyB7HAC9A8IGNHNUgy9eLKCx
         iZXoCiOeOzsVu+Dn4K2DSnZZFEIelNeTyw3rMRXNsSOJbzSN5Jry2tiaoD+ZsUljnk13
         fx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708681322; x=1709286122;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5vxAQbq8EgE/2JJwOSWCuGz+rEc2pK5AZO+RpGD7vjU=;
        b=ayU/oY6Q0ZId1tzOQY/iWrJS31Hy3fnn8rU+zIU7g02z+4CTdctlivLdGORJ50ODJx
         KKjAAD7qbDIugGyXKW8hfaUkp+OlX07xGoA3VGzI2NIOruIq1+I0dI3Tl96RgjsUu7EQ
         qjtJWHQszH5YbLvaNE452qjG0ia5Q97HXPk/BjmkAEgPHc/+DjiecB+QrzvCNS9lTbR8
         4Zxy5U0j6WOVf+kWnxmYKwNbbprwSE4vSsJbBJ4ARxPV/K9/Sj0Jo4hLymRchNnUoEO7
         bq93FbqqOoM3cJuhWCeoxKRaerd/49z+VscQP6IkPhMccbGTI1IgapMC7iHinjmwedwG
         04pQ==
X-Gm-Message-State: AOJu0YwexCV5rugt//g4wvLhsEUv8KQkSGgZJ5Z7hPlHwsQ3U9AQWumK
	brooyVfLwfIvtSAlrpF9V1JiKthpFr5/HnC7CmGiieyxWvGu28exDaSUfIKM9FtxUw+ZFGr+vlP
	nFdBemBxFhpcaxQ2dU5hRh/DbcEJ1140OLS2TLvVv6auHAgt9r1U=
X-Google-Smtp-Source: AGHT+IG0N4VJnp/KUVxYjf1fciYRrnpy+8/D6UbSyiGGRLADO/cLSUIw+vE0FGeULCCxFvRJYk7YJZeVVUtr0oRwwIs=
X-Received: by 2002:a1f:e681:0:b0:4c8:e834:6cf2 with SMTP id
 d123-20020a1fe681000000b004c8e8346cf2mr1288542vkh.3.1708681322074; Fri, 23
 Feb 2024 01:42:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 23 Feb 2024 15:11:50 +0530
Message-ID: <CA+G9fYvWp8TY-fMEvc3UhoVtoR_eM5VsfHj3+n+kexcfJJ+Cvw@mail.gmail.com>
Subject: s390: s390x-linux-gnu-ld: Unexpected GOT/PLT entries detected!
To: open list <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, 
	lkft-triage@lists.linaro.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

[ Please ignore this email if it is already reported ]

The s390 gcc-8 builds failed on Linux next tag next-20240215..next-20240223.
First build failures noticed on tag next-20240215 for both gcc-13 and gcc-8.
But from the next tag next-20240216 gcc-13 passed but gcc-8 failed.

s390:
    - defconfig-fe40093d - gcc-8 - Failed
    - tinyconfig - gcc-8 - Failed
    - allnoconfig - gcc-8 - Failed

    - defconfig-fe40093d - gcc-13 - Pass from next-20240216
    - tinyconfig - gcc-13 - Pass from next-20240216
    - allnoconfig - gcc-13 - Pass from next-20240216

Build log:
---------
s390x-linux-gnu-ld: Unexpected GOT/PLT entries detected!
make[3]: *** [/builds/linux/arch/s390/boot/Makefile:87:
arch/s390/boot/vmlinux.syms] Error 1
make[3]: Target 'arch/s390/boot/bzImage' not remade because of errors.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Steps to reproduce:
 $ tuxmake --runtime podman --target-arch s390 --toolchain gcc-8
--kconfig tinyconfig

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240223/testrun/22812529/suite/build/test/gcc-8-defconfig-fe40093d/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2cl8pys1B3Vc4oOB2yXcaYkfnKw/

--
Linaro LKFT
https://lkft.linaro.org

