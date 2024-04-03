Return-Path: <linux-kernel+bounces-129238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760E789677B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C8A1C25474
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA80608ED;
	Wed,  3 Apr 2024 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eKtsTEQo"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240A75674A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131438; cv=none; b=VyVE32Z1Mx2k1Yj6IWdpXhwjh5OAaftCz3UYw6OjEJI5z5nqog84xQxEkwV0F1Jt3shtjKAKcQC6oti/c4QGXKVkOzvyqx18x7SBS5l5qyiGK3UBKbd8TWfrlUE2vQ4/2NYLwscXbvTqGTfv8cl3GGXbyZSSVEa5CrhO9GZBm+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131438; c=relaxed/simple;
	bh=KjDKKZQAsR2x90HWBcTUfYwToWStcC316tpU9s74CdM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dy9mmSWonQwL1xqifR0pt5vwHzuCW/DRpmgIRe4Zk3LvzgD69J6fmLtyEdCCfuEHmnMcex7e9g3HKjjRKFb/DaMLiKuOQc5Qm5Zn0AmRDIxkCVQEkYj72Z2uW7s3UAZMAmZsvSxasd4mr2fPSo9rjfrRGuPa5JF3gEYIM5D4WWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eKtsTEQo; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7e0425e5aa8so2096129241.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 01:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712131435; x=1712736235; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KF5rMcRDqQoWBU2qheNbp11b4MuIV67CJIqxgZePRvk=;
        b=eKtsTEQoPcCMcrQRMaS193+c0qVC32HBWcUhyXn5W8sypHXae+bRY7cGwHUoA9VvIR
         VPDZ7I9d9hGObOz7c7C1H08zHA0LwuDDhEhABTaT+l/w52/rQE1jMM6yC3cLwDYwtefu
         M+eTEFDEDFOu9jJVn0GFOQCcetms9/hmU0RWZ/K3U+QFhRGYz6npz2xFAAPGtuReO01Y
         h8T4VHIEUl2Lp5KAUIeXx3Ql/TvQ8iHgr9zUi8ueBf/OFfFYfVjQpzkhdlFOk80QTPIM
         pl8pzLxrZSfhA783xbb96HVnJOZOCNofSpOhmmwgnfb4o3GpCswHC1cxdyItXn4QEQAe
         VXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131435; x=1712736235;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KF5rMcRDqQoWBU2qheNbp11b4MuIV67CJIqxgZePRvk=;
        b=h5thj9uliyl8TFDfF1rJtu1cBOp04cfp3WtKluaIzjwwdX85ZXuAJpEhF46Ja2qOEy
         HzwVlzzvjL7PJkfYxtD54iZBw7e2fS2Zp2p6Qi29od77y/Ca01sPsPFHMb8pPytnWBIZ
         K0IvysOkCWeyFG3ETn/EOmXNYCQwMD6Sk2QRW1N8R0uvr9KylBl1itcMmJObaANR0x/j
         PAroTFwf3dTWQQEwMfbtYGoqFv8LYdcVLlNJoKkVlOoZ+kWiBqQ80l3Czu2O1LjbPQJe
         Br9l4TtP7mu07SmEOYeFcAnHL+4qUa4pKm2vPQ6X/cEcBO6pXmhk9I3ijxnGDjQYHK9i
         oYnA==
X-Gm-Message-State: AOJu0Yysm2AbenkGRod4jW0lBc0qneE9S4Gc+zvKOUAgObUeEz8zb8vP
	Fi0ZGOtWSmkUaYFOcFaZoI0vDjrIfn3+xewBQckLyBWnCo5vJb1tRemdc4rBerQHhLqDxh1Ns/f
	9W1quYCWFcrbnrSDEZ2SWL/i53G6NGk/1cfyG2Ri0c1MXjQQu+ro=
X-Google-Smtp-Source: AGHT+IF2bSuMQc4R8MCFBCOJr83VFrCimkABelAQd1QiE/nIT3+sNxsbnogNduwIzLN2Oc0WhC2CzgR9vBfGuKNzyv8=
X-Received: by 2002:a05:6102:3753:b0:476:fa5b:e826 with SMTP id
 u19-20020a056102375300b00476fa5be826mr2565038vst.4.1712131435492; Wed, 03 Apr
 2024 01:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Apr 2024 13:33:44 +0530
Message-ID: <CA+G9fYtsoP51f-oP_Sp5MOq-Ffv8La2RztNpwvE6+R1VtFiLrw@mail.gmail.com>
Subject: include/linux/build_bug.h:78:41: error: static assertion failed:
 "struct bpf_fib_lookup size check"
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, David Ahern <dsahern@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, aleksander.lobakin@intel.com
Content-Type: text/plain; charset="UTF-8"

The arm footbridge_defconfig failed with gcc-13 and gcc-8 on Linux next
starting from next-20240328..next-20240402.

arm:
  build:
    * gcc-8-footbridge_defconfig - Failed
    * gcc-13-footbridge_defconfig - Failed

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

In file included from include/linux/bitfield.h:10,
                 from arch/arm/include/asm/ptrace.h:13,
                 from arch/arm/include/asm/processor.h:14,
                 from include/linux/prefetch.h:15,
                 from arch/arm/include/asm/atomic.h:12,
                 from include/linux/atomic.h:7,
                 from net/core/filter.c:20:
include/linux/build_bug.h:78:41: error: static assertion failed:
"struct bpf_fib_lookup size check"
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                         ^~~~~~~~~~~~~~

Steps to reproduce:
------
# tuxmake --runtime podman --target-arch arm --toolchain gcc-13
--kconfig footbridge_defconfig

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240402/testrun/23264362/suite/build/test/gcc-13-footbridge_defconfig/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2eWtBPKv1yM8gfZJC8GkEkxN2j8/

--
Linaro LKFT
https://lkft.linaro.org

