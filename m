Return-Path: <linux-kernel+bounces-124465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F320D89186C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58ABE1F21DD4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F73585631;
	Fri, 29 Mar 2024 12:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="WRXEiJQu"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC46F823CD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711714461; cv=none; b=suyi19kAk30VmXRMlVvP3+fCVLs8CbWSxWGm4zp7rAN+aItIL1xasu1JrvQWwJeef4Xmq0+9WWz/6VBeS3diOQx1fGeCXxuWQuAR/yYLDYpZkg57KWPcwGdhVoozeP5uChjjxwETYwRVlPf0kWuh2jC73UavoDnptNZIoyxI0P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711714461; c=relaxed/simple;
	bh=6kT46Qgd01hm1jmGaKhac/lHd2aIR6bHCVN9T5DzY14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bLImOnCej/wmnkCW0T27EK2ZzPEpWBQs/ax0K+v0U0Ac8WdHEK84sKSYqds6XgTRxmGVv5WtZubPtme+IyuwXYRsu3+MufJ0x9ETtpwJierFhlNK2uBlCv4YrRFBhLBJ5RNZY+kIFzVkav8ccpuOmJh1KRvW5yxhVmLp1Hnwq7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=WRXEiJQu; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4a3a5e47baso243781466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 05:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1711714458; x=1712319258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OO1k6uOo9XO4/TXWsGym98But5cvRnet8GLuLLdO1bA=;
        b=WRXEiJQuXkOSaeo4wFB7xDucLiQdC315Zko0wDgFrx0zvONIkRG5p3l3CAmPE+1qvo
         BCAZpDXJjYhLIqLLCogX7Wn+lz82fCLMz+WVY5Jhvfv8CON6ZVZ8UW/PNEoe6Op4nqyO
         m0r+5BrJI9Ju8PxNCF8vyjmvaM4kOwDDa4ghtlxQDgnlBWs9u09zkFldNGadHaoDYHnH
         YSMSF1JcGhqLKzsm7xugIvykhRRZgy7HrLmCy8UnyR21d7979Hu72A5jBG+QSVqCmPdZ
         y0FOhRYfFkHADuTnpCh9aqpAcuvXJLrXNQIsu+WlAUZ0wwhmRsrBEuCenohOIIvB+Iv7
         d9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711714458; x=1712319258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OO1k6uOo9XO4/TXWsGym98But5cvRnet8GLuLLdO1bA=;
        b=VqGgYY0lrijkO4SgoPKGFB9e0xII9zN5mWvCj+HkMiMr3mUGwpIHIu0EaUWgFePrNU
         MmAHkOqTuHGPtRCEhQAk5lHRbZ7NnLE4q9oNo7RVwNUlTQ/j6hri+hlpyAEGQo/FBCgn
         btI1nign3bmskkqTpKOvE79lWAQRqMEvPM2m968lw/pvxI5xj9AEds6YZTl7glFyvb20
         ewW6HHtdpGXi8f7ly0gVfLoKDtUTYTaa9he4PR+QNTLdx/oMd5Ol74ykhzBFmEPaCTM+
         m/q2FBlvm4GsSNIvnpU8kTPbyB4HtDk3aBjKPJ/mzgeU+VL+a36YUTsrKsGuwomtVgNv
         Dw1g==
X-Forwarded-Encrypted: i=1; AJvYcCVS8s6LFizeXrgTkEpD2RKw0H9FECYhH78clChK+0WUNGjEzyzSb5AOsew6wh9uIoEBFICO1iHwU+zavsr/5EnOcCQYnifC2VLk+WtP
X-Gm-Message-State: AOJu0YyGOnw6wfqE2+S9j0qOyrzvSSY2LIDV5BbgoImFJ9UjbOa9rH2G
	yAqm1U96btKyqrYlTfTP40iHPUkYdz3bD0PiYStd7JKhsJszXLGAFDwtY6oLjBY=
X-Google-Smtp-Source: AGHT+IH9fWrgL09gu878bMaJvlMckx22/uvLhk+HizZG/nZ6JnFE48PaEKy3+j21KwsT+VDdHsQ0pQ==
X-Received: by 2002:a17:906:a459:b0:a4e:def:ffc3 with SMTP id cb25-20020a170906a45900b00a4e0defffc3mr1574068ejb.5.1711714458218;
        Fri, 29 Mar 2024 05:14:18 -0700 (PDT)
Received: from antares.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906539000b00a46dd1f7dc1sm1869942ejo.92.2024.03.29.05.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 05:14:17 -0700 (PDT)
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
	Alexandre Ghiti <alex@ghiti.fr>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [PATCH v2 0/2] RISC-V: Test th.sxstatus.MAEE bit before enabling MAEE
Date: Fri, 29 Mar 2024 13:14:12 +0100
Message-ID: <20240329121414.688391-1-christoph.muellner@vrull.eu>
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

The main issue is, that Linux enables MAEE for CPUs that have a T-Head
mvendorid but QEMU maintainers don't want to emulate a CPU that uses
reserved bits in PTEs. See also the following discussion for more
context:
  https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg00775.html

This series renames "T-Head PBMT" to "MAEE" and only enables it if
the th.sxstatus.MAEE bit is set.

The th.sxstatus CSR is documented here:
  https://github.com/T-head-Semi/thead-extension-spec/pull/46

The QEMU patch to emulate th.sxstatus with MAEE not set is here:
  https://lore.kernel.org/all/20240329120427.684677-1-christoph.muellner@vrull.eu/

After applying the referenced QEMU patch, this patchset allows to
successfully boot a C906 QEMU system emulation ("-cpu thead-c906").

Christoph Müllner (2):
  riscv: thead: Rename T-Head PBMT to MAEE
  riscv: T-Head: Test availability bit before enabling MAEE errata

 arch/riscv/Kconfig.errata            |  8 ++++----
 arch/riscv/errata/thead/errata.c     | 22 ++++++++++++++--------
 arch/riscv/include/asm/errata_list.h | 20 ++++++++++----------
 3 files changed, 28 insertions(+), 22 deletions(-)

-- 
2.44.0


