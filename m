Return-Path: <linux-kernel+bounces-164189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD5C8B7A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488F628723C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA7E14375C;
	Tue, 30 Apr 2024 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPtX7lVO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EFA1527A8;
	Tue, 30 Apr 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488259; cv=none; b=LxI3ei0CH1JwEgnQ0ULKCbLrQDCdUi7/KhySd0k3A+3vnZjoafuUxhkV+jpGxlMT1lUgQljNpAoE20vbQnJ9luBrQOvctBV92vFo5EZgXnwjN0CkYRM8Kn1/IPktEoG2WNHJ6V8UMpwYX8dd2sF72mhD/npBL+3apmyjuDFMPPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488259; c=relaxed/simple;
	bh=ITJBFO8fU5qCoPRWLyqfUK06OptlD/pVjoJj4mvvjlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=diazgDPK5TDL8oQoq1cZ/rQoz1S/RYbgI4CR/+JmnL5/9GhoFJajRGt9Dt/xdrs7XJyCdFal2jFz/FGgbBZKfHXDrA1u/9ZAGjh1+Sjq/vmiCjUtlcSMw1keEz1lVxtAJNNkBHGLo0jsZZPr2Fa7WTZFyuENDhBYlw1/ksCAC0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPtX7lVO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714488258; x=1746024258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ITJBFO8fU5qCoPRWLyqfUK06OptlD/pVjoJj4mvvjlc=;
  b=RPtX7lVOuIkDhJRi3CV5kiBn9svtvK0JefRJimC6nmif7bu7wvGAUX1h
   4rjm8et5B2aZuEcJ2ZY/o5onnOWoklDFVsaDZY1wPHiF55gbawH968YH6
   Pi+xFIiIx2uvtWerahBEP5bjpW1S3EVEhtK01mL8+bRdSft/r7qv8D5ey
   ru3b0l6hFasIVqQy0AHDEezzFwgggRDTpSg6RkKgQTerMA2rrmn9rjnJa
   aRHqwrsYKsC1P8zxvBfBk1L2ep2mpZ0I9A2Wyg10pz0x1OfXQojNRLDKW
   ve9EofxtQwKYIegogKHQOi+u1rLi8jciFu32krQKy8m4CiGtxW/vRIvcB
   g==;
X-CSE-ConnectionGUID: cjlnOjnjT0mtOc5rUmuVAg==
X-CSE-MsgGUID: eWjQD2fyQICMVGs8n8lkCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10420084"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10420084"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:44:17 -0700
X-CSE-ConnectionGUID: CgbXh7TnQSaFTyUXC+T2Nw==
X-CSE-MsgGUID: /9seFNKQR1uxdDrqYlKm/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26491447"
Received: from mehlow-prequal01.jf.intel.com ([10.54.102.156])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:44:16 -0700
From: Dmitrii Kuvaiskii <dmitrii.kuvaiskii@intel.com>
To: jarkko@kernel.org
Cc: dave.hansen@linux.intel.com,
	dmitrii.kuvaiskii@intel.com,
	haitao.huang@linux.intel.com,
	kai.huang@intel.com,
	kailun.qin@intel.com,
	linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	mona.vij@intel.com,
	reinette.chatre@intel.com
Subject: Re: [PATCH 0/2] x86/sgx: Fix two data races in EAUG/EREMOVE flows
Date: Tue, 30 Apr 2024 07:35:55 -0700
Message-Id: <20240430143555.893316-1-dmitrii.kuvaiskii@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <D0WMNTCRUN00.TQHC8O6X6WI2@kernel.org>
References: <D0WMNTCRUN00.TQHC8O6X6WI2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Deutschland GmbH - Registered Address: Am Campeon 10, 85579 Neubiberg, Germany
Content-Transfer-Encoding: 8bit

On Mon, Apr 29, 2024 at 04:06:39PM +0300, Jarkko Sakkinen wrote:
> On Mon Apr 29, 2024 at 1:43 PM EEST, Dmitrii Kuvaiskii wrote:
> > SGX runtimes such as Gramine may implement EDMM-based lazy allocation of
> > enclave pages and may support MADV_DONTNEED semantics [1]. The former
> > implies #PF-based page allocation, and the latter implies the usage of
> > SGX_IOC_ENCLAVE_REMOVE_PAGES ioctl.
> >
> > A trivial program like below (run under Gramine and with EDMM enabled)
> > stresses these two flows in the SGX driver and hangs:
> >
> > /* repeatedly touch different enclave pages at random and mix with
> >  * `madvise(MADV_DONTNEED)` to stress EAUG/EREMOVE flows */
> > static void* thread_func(void* arg) {
> >     size_t num_pages = 0xA000 / page_size;
> >     for (int i = 0; i < 5000; i++) {
> >         size_t page = get_random_ulong() % num_pages;
> >         char data = READ_ONCE(((char*)arg)[page * page_size]);
> >
> >         page = get_random_ulong() % num_pages;
> >         madvise(arg + page * page_size, page_size, MADV_DONTNEED);
> >     }
> > }
> >
> > addr = mmap(NULL, 0xA000, PROT_READ | PROT_WRITE, MAP_ANONYMOUS, -1, 0);
> > pthread_t threads[16];
> > for (int i = 0; i < 16; i++)
> >     pthread_create(&threads[i], NULL, thread_func, addr);
> 
> I'm not convinced that kernel is the problem here but it could be also
> how Gramine is implemented.
> 
> So maybe you could make a better case of that. The example looks a bit
> artificial to me.

I believe that these are the bugs in the kernel (in the SGX driver). I
provided more detailed descriptions of the races and ensuing bugs in the
other two replies, please check them.

The example is a stress test written to debug very infrequent hangs of
real-world applications that are run with Gramine, EDMM, and two
optimizations (lazy allocation and MADV_DONTNEED semantics). We observed
hangs of Node.js, PyTorch, R, iperf, Blender, Nginx. To root cause these
hangs, we wrote this artificial stress test. This test succeeds on vanilla
Linux, so ideally it should also pass on Gramine.

Please also note that the optimizations of lazy allocation and
MADV_DONTNEED provide significant performance improvement for some
workloads that run on Gramine. For example, a Java workload with a 16GB
enclave size has approx. 57x improvement in total runtime. Thus, we
consider it important to permit these optimizations in Gramine, which IIUC
requires bug fixes in the SGX driver.

You can find more info at
https://github.com/gramineproject/gramine/pull/1513.

Which parts do you consider artificial, and how could I modify the stress
test?

--
Dmitrii Kuvaiskii

