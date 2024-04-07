Return-Path: <linux-kernel+bounces-134647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C3389B416
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 23:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8762812DA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 21:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B6944C7B;
	Sun,  7 Apr 2024 21:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="n14AkOZ/"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CED3CF7E
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712525563; cv=none; b=B3oe7YPLBXt+lsQ9LMu71y/obvZFjNWpdXtZ+oKfLtPXwVI+UuWQVCFi3ic0m29mTkPUBCqdybVsxsQhiL9dXH2YwuY2NunWBmkY1EtMcGfSwERsMBPVDyGJ+FknTBW4p/LxFRhMeJ1NOsMzQ7SxwGWNxnj3KwWc6P1A4Nj51fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712525563; c=relaxed/simple;
	bh=eABqFm9xwdcF30kdGzraxqWLkWDPOvBi+NFuvQeLCso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ahfaS7c6rfEfFg/HPyg7OiPwa9X/8UQWYsEIvCStESnIhpnPzWOzZttqH4KpzW2/lISCaJzLz+WOBu9b85ZtXx/U+9ykG0nudroiw4ObSjAl1E4oznX0hPTBFnQ6BUgNZKpkzNj2KuunlkwmiLHV6ruuKm5Hv0TYaEXSD2S+3Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=n14AkOZ/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e449187fcso1284003a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 14:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1712525560; x=1713130360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a+DOPqB+KLlf2OTXo3h+6/GJSa1MbFuatLtGIKQirtk=;
        b=n14AkOZ/MkW1BAy6gRGRmCYMoYfu5vnIxfqIGPDyqIEcuaNBH5gEBl+urn9ZUVFCdO
         tELnwF9lLUTI75pl+aGlPc4Lyv3/GLfp+YKSQwS4PyXWUNw/tPhtIRKP1KZowFbwOuzh
         vqijCMZkDY5zEBF4imph/F6Rcme9pdyjM8Tdm55pZHnt+BhPkY+3me6vw/5oCXkBLgqE
         DjZZaX47UO6t6rWBmzer4EbbgmRCy42FV9wB+6AgfJRlR/4RZuf+BXU13nW0GvEdKRwC
         Sp4JuWGUEVAW8HKU/O+qpiB8zrOTaVfvgkmfvocZPlFBK9H2uritMjoMcWutF2vvZLMQ
         KIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712525560; x=1713130360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+DOPqB+KLlf2OTXo3h+6/GJSa1MbFuatLtGIKQirtk=;
        b=w5F5McEjp8idOpzmidOPW38S2c2sDVFPR6XqUBP/nnG3RW5PKmG7NjDcqL8tr1PCUs
         hYNtF6LKhmpjnNCw/G06Zj32a5ni4U1OMSCHdlUsbogUKPWtoHngdiTW9hsBqeyQqO7X
         Pce0X9HEC8LIUOLzRBP2OfWO/Ko4CZfjIrWEkllIhaCtCtlRC5U3Yg71zaIHP7leJHqj
         wUAOCcYUHJ0yg9LUQCuA+9KntvwQQudkacIk2Zw6urGaucamO80Qhyhotqfy4QVfFOQQ
         Bth70gIoMapxUE8BHBZlUBr0Ck7r8yjYraWwmOoat93v1xqM6QBzP1TEh/m2UTGzwfWi
         malg==
X-Forwarded-Encrypted: i=1; AJvYcCVgIthtY7WXZwC9trMnMKjK1X10KZFxzpZ7DhTpsKIGWGFKvwLBRQqwv5zKIKJvg0xniHu+93FQm2r0gUzfZYmu/UCYK9ZL3vDcRuAl
X-Gm-Message-State: AOJu0Ywp4H5F3KE90jGG/Xoo0CfDrJ3lvzo3GKxdU3VmqIHMsH7xrASn
	GJ2KLbr/koDQrSx0mKQ5zh6EFnA7ASvdj/OveMo/FVvmAHAnj0PyUUUxBqCbVwU=
X-Google-Smtp-Source: AGHT+IFu8nywPo6SltvVHHM6OeIZviiVKvv1KckE1rqsAWhmLSADm7+GxdfQbJAflNLCBpcMCE2IEg==
X-Received: by 2002:a50:a6da:0:b0:56e:2e94:2964 with SMTP id f26-20020a50a6da000000b0056e2e942964mr4529195edc.15.1712525559515;
        Sun, 07 Apr 2024 14:32:39 -0700 (PDT)
Received: from antares.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id i2-20020a50fc02000000b0056e22be831dsm3267562edr.42.2024.04.07.14.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 14:32:39 -0700 (PDT)
From: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Cooper Qu <cooper.qu@linux.alibaba.com>,
	Zhiwei Liu <zhiwei_liu@linux.alibaba.com>,
	Huang Tao <eric.huang@linux.alibaba.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor@kernel.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [PATCH v3 0/2] RISC-V: Test th.sxstatus.MAEE bit before enabling MAEE
Date: Sun,  7 Apr 2024 23:32:34 +0200
Message-ID: <20240407213236.2121592-1-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, the Linux kernel suffers from a boot regression when running
on the c906 QEMU emulation. Details have been reported here by Björn Töpel:
  https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg04766.html

The main issue is, that Linux enables XTheadMae for CPUs that have a T-Head
mvendorid but QEMU maintainers don't want to emulate a CPU that uses
reserved bits in PTEs. See also the following discussion for more
context:
  https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg00775.html

This series renames "T-Head PBMT" to "MAE"/"XTheadMae" and only enables
it if the th.sxstatus.MAEE bit is set.

The th.sxstatus CSR is documented here:
  https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheadsxstatus.adoc

XTheadMae is documented here:
  https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheadmae.adoc

The QEMU patch to emulate th.sxstatus with the MAEE bit not set is here:
  https://lore.kernel.org/all/20240329120427.684677-1-christoph.muellner@vrull.eu/

After applying the referenced QEMU patch, this patchset allows to
successfully boot a C906 QEMU system emulation ("-cpu thead-c906").

Changes in v3:
* Rename to MAE instead of MAEE

Changes in v2:
* use th.sxstatus.MAEE instead of th.mxstatus.MAEE

Christoph Müllner (2):
  riscv: thead: Rename T-Head PBMT to MAE
  riscv: T-Head: Test availability bit before enabling MAE errata

 arch/riscv/Kconfig.errata            |  8 ++++----
 arch/riscv/errata/thead/errata.c     | 24 +++++++++++++++---------
 arch/riscv/include/asm/errata_list.h | 20 ++++++++++----------
 3 files changed, 29 insertions(+), 23 deletions(-)

-- 
2.44.0


