Return-Path: <linux-kernel+bounces-14798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C523822278
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C1F1C21FF0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DAD1641A;
	Tue,  2 Jan 2024 20:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jBZq+QIm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF7416408;
	Tue,  2 Jan 2024 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (c-73-239-240-195.hsd1.wa.comcast.net [73.239.240.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8634120B3CC1;
	Tue,  2 Jan 2024 12:18:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8634120B3CC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704226728;
	bh=JFUj3C7F4v1llVh0SHjV/UZr4Y8Q5mWVzW88656cZ4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jBZq+QImwExtqzfSMUaFBx5SqLCBQZlhbdMiNYB9OQZDuVtBKnZllTeupWgAKu58t
	 4yOsU39+h82ZiQ2rxDh7b264mytw7f1GFBNGYW+/MioPPM90R/n2xElpJXMoDcvHCU
	 nesWzuBT96S1hmpCoXyzFXlJiuFt3xFbHxdqt+iM=
Date: Sun, 31 Dec 2023 19:55:18 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Alexander Graf <graf@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>, arnd@arndb.de,
	pbonzini@redhat.com, madvenka@linux.microsoft.com,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 07/17] kexec: Add documentation for KHO
Message-ID: <20240101035518.GA804@skinsburskii.>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222193607.15474-8-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222193607.15474-8-graf@amazon.com>

On Fri, Dec 22, 2023 at 07:35:57PM +0000, Alexander Graf wrote:
> diff --git a/Documentation/kho/concepts.rst b/Documentation/kho/concepts.rst
> new file mode 100644
> index 000000000000..8e4fe8c57865
> --- /dev/null
> +++ b/Documentation/kho/concepts.rst
> @@ -0,0 +1,88 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +=======================
> +Kexec Handover Concepts
> +=======================
> +
> +Kexec HandOver (KHO) is a mechanism that allows Linux to preserve state -
> +arbitrary properties as well as memory locations - across kexec.
> +
> +It introduces multiple concepts:
> +
> +KHO Device Tree
> +---------------
> +
> +Every KHO kexec carries a KHO specific flattened device tree blob that
> +describes the state of the system. Device drivers can register to KHO to
> +serialize their state before kexec. After KHO, device drivers can read
> +the device tree and extract previous state.
> +
> +KHO only uses the fdt container format and libfdt library, but does not
> +adhere to the same property semantics that normal device trees do: Properties
> +are passed in native endianness and standardized properties like ``regs`` and
> +``ranges`` do not exist, hence there are no ``#...-cells`` properties.
> +
> +KHO introduces a new concept to its device tree: ``mem`` properties. A
> +``mem`` property can inside any subnode in the device tree. When present,

Should it be "property can be" ?

...

> diff --git a/Documentation/kho/usage.rst b/Documentation/kho/usage.rst
> new file mode 100644
> index 000000000000..5efa2a58f9c3
> --- /dev/null
> +++ b/Documentation/kho/usage.rst
> @@ -0,0 +1,57 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +====================
> +Kexec Handover Usage
> +====================
> +
> +Kexec HandOver (KHO) is a mechanism that allows Linux to preserve state -
> +arbitrary properties as well as memory locations - across kexec.
> +
> +This document expects that you are familiar with the base KHO
> +:ref:`Documentation/kho/concepts.rst <concepts>`. If you have not read
> +them yet, please do so now.
> +
> +Prerequisites
> +-------------
> +
> +KHO is available when the ``CONFIG_KEXEC_KHO`` config option is set to y
> +at compile team. Every KHO producer has its own config option that you

Should it be "at compile time."?
 

