Return-Path: <linux-kernel+bounces-158529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8647D8B21B5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A97221C22A16
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3391494AD;
	Thu, 25 Apr 2024 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DtGdkloK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FA231A8F;
	Thu, 25 Apr 2024 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714048447; cv=none; b=lABDCs+eV6ClklVRrK/7/URo0z0omr/19I7qITwxLmsrXXBL6jJMYWQnpCsukQpLJQvXrBvJV0c2rdXhzFXU6DUgCHRLlIYtCzgNKv7PHB8jtmr760wdjoTo3CGzddHCS8EiKeUji3AAVCi0Zu0yXWyXNW0ySwKaeeU0LvpUjZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714048447; c=relaxed/simple;
	bh=fHSWK6RaKzzRJxtJU/y87+W/7EsCcfwXvk+QNYX1BTA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bgdAyP8ODEOAi7N7KS6JAYa5AkbxVGDhuZ2tWykam4cIAe0FJm6qeL+n2sZ6DyEQX2eUXeBEWzmtbatDF225TyXrVPpF5Jx19gYmqKh9UN5l7welHMjS4Dr+BQY9sB1wKAaZM7QfjOpAfMNLDFFwfQTTXM2FdCqOmMg7U4Z+RqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DtGdkloK; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714048445; x=1745584445;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=fHSWK6RaKzzRJxtJU/y87+W/7EsCcfwXvk+QNYX1BTA=;
  b=DtGdkloKJ08zWqJJzUTw81uiU+kD7Fq4Agzd11aBfmhcIL9Zy9UxBPuS
   +5ePDFD+Ql+z9K+UGN2pJwJCczpS7QQw7RoMiH6avp9RZrJ4r/eHAApTR
   8V6UloOoQOM8QAKjasZQBPWQfBzVZo9rabymxAfiY0OSLl2NcNJaNmsXs
   X9SV67NBWSNovAF0CoBuuWyfAU8hflKHm1a/VzsSFmJzpA0dgA8bRyqnT
   wpYP+ILirb/ltdF+j858EGz2Ril1DoaJfbw5jc/qVwP2N6RwtC5u8dlDA
   3cRs+r/8iljnL7jrVV53W3NytHNtNhm40DgmAZzBqwY08v7ohjOMceb5D
   w==;
X-CSE-ConnectionGUID: lM1H4MPJTvqJgTzSQxZCtQ==
X-CSE-MsgGUID: 4FNGJpfHRna3CCA0c6YSOw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9554649"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="9554649"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 05:34:01 -0700
X-CSE-ConnectionGUID: xQ4tXUBaRuiTwz1TjJXAMw==
X-CSE-MsgGUID: Qku2+xYGSi63N4eI8GYhNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="62537719"
Received: from spandruv-desk.jf.intel.com (HELO spandruv-desk.amr.corp.intel.com) ([10.54.75.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 05:34:01 -0700
Message-ID: <23fc6b57a5749b37b13afcf4424c0166ec3f51a5.camel@linux.intel.com>
Subject: Re: [PATCH v4 65/71] platform/x86: intel-uncore-freq: Switch to new
 Intel CPU model defines
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Hans de
 Goede <hdegoede@redhat.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Date: Thu, 25 Apr 2024 05:34:01 -0700
In-Reply-To: <20240424181544.42407-1-tony.luck@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
	 <20240424181544.42407-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI0LTA0LTI0IGF0IDExOjE1IC0wNzAwLCBUb255IEx1Y2sgd3JvdGU6Cj4gTmV3
IENQVSAjZGVmaW5lcyBlbmNvZGUgdmVuZG9yIGFuZCBmYW1pbHkgYXMgd2VsbCBhcyBtb2RlbC4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBUb255IEx1Y2sgPHRvbnkubHVja0BpbnRlbC5jb20+CkFja2Vk
LWJ5OiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVs
LmNvbT4KCj4gLS0tCj4gwqAuLi4vaW50ZWwvdW5jb3JlLWZyZXF1ZW5jeS91bmNvcmUtZnJlcXVl
bmN5LmMgfCA1NiArKysrKysrKystLS0tLS0tLQo+IC0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgMjgg
aW5zZXJ0aW9ucygrKSwgMjggZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGxhdGZvcm0veDg2L2ludGVsL3VuY29yZS1mcmVxdWVuY3kvdW5jb3JlLQo+IGZyZXF1ZW5jeS5j
IGIvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwvdW5jb3JlLWZyZXF1ZW5jeS91bmNvcmUtCj4g
ZnJlcXVlbmN5LmMKPiBpbmRleCBiODljMGRkYTllNWQuLmI4MGZlYWY1ODI4ZiAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC91bmNvcmUtZnJlcXVlbmN5L3VuY29yZS1m
cmVxdWVuY3kuYwo+ICsrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3VuY29yZS1mcmVx
dWVuY3kvdW5jb3JlLWZyZXF1ZW5jeS5jCj4gQEAgLTE5NywzNCArMTk3LDM0IEBAIHN0YXRpYyBz
dHJ1Y3Qgbm90aWZpZXJfYmxvY2sgdW5jb3JlX3BtX25iID0gewo+IMKgfTsKPiDCoAo+IMKgc3Rh
dGljIGNvbnN0IHN0cnVjdCB4ODZfY3B1X2lkIGludGVsX3VuY29yZV9jcHVfaWRzW10gPSB7Cj4g
LcKgwqDCoMKgwqDCoMKgWDg2X01BVENIX0lOVEVMX0ZBTTZfTU9ERUwoQlJPQURXRUxMX0cswqBO
VUxMKSwKPiAtwqDCoMKgwqDCoMKgwqBYODZfTUFUQ0hfSU5URUxfRkFNNl9NT0RFTChCUk9BRFdF
TExfWCzCoE5VTEwpLAo+IC3CoMKgwqDCoMKgwqDCoFg4Nl9NQVRDSF9JTlRFTF9GQU02X01PREVM
KEJST0FEV0VMTF9ELMKgTlVMTCksCj4gLcKgwqDCoMKgwqDCoMKgWDg2X01BVENIX0lOVEVMX0ZB
TTZfTU9ERUwoU0tZTEFLRV9YLMKgwqDCoE5VTEwpLAo+IC3CoMKgwqDCoMKgwqDCoFg4Nl9NQVRD
SF9JTlRFTF9GQU02X01PREVMKElDRUxBS0VfWCzCoMKgwqBOVUxMKSwKPiAtwqDCoMKgwqDCoMKg
wqBYODZfTUFUQ0hfSU5URUxfRkFNNl9NT0RFTChJQ0VMQUtFX0QswqDCoMKgTlVMTCksCj4gLcKg
wqDCoMKgwqDCoMKgWDg2X01BVENIX0lOVEVMX0ZBTTZfTU9ERUwoU0FQUEhJUkVSQVBJRFNfWCwg
TlVMTCksCj4gLcKgwqDCoMKgwqDCoMKgWDg2X01BVENIX0lOVEVMX0ZBTTZfTU9ERUwoRU1FUkFM
RFJBUElEU19YLCBOVUxMKSwKPiAtwqDCoMKgwqDCoMKgwqBYODZfTUFUQ0hfSU5URUxfRkFNNl9N
T0RFTChLQUJZTEFLRSwgTlVMTCksCj4gLcKgwqDCoMKgwqDCoMKgWDg2X01BVENIX0lOVEVMX0ZB
TTZfTU9ERUwoS0FCWUxBS0VfTCwgTlVMTCksCj4gLcKgwqDCoMKgwqDCoMKgWDg2X01BVENIX0lO
VEVMX0ZBTTZfTU9ERUwoQ09NRVRMQUtFLCBOVUxMKSwKPiAtwqDCoMKgwqDCoMKgwqBYODZfTUFU
Q0hfSU5URUxfRkFNNl9NT0RFTChDT01FVExBS0VfTCwgTlVMTCksCj4gLcKgwqDCoMKgwqDCoMKg
WDg2X01BVENIX0lOVEVMX0ZBTTZfTU9ERUwoQ0FOTk9OTEFLRV9MLCBOVUxMKSwKPiAtwqDCoMKg
wqDCoMKgwqBYODZfTUFUQ0hfSU5URUxfRkFNNl9NT0RFTChJQ0VMQUtFLCBOVUxMKSwKPiAtwqDC
oMKgwqDCoMKgwqBYODZfTUFUQ0hfSU5URUxfRkFNNl9NT0RFTChJQ0VMQUtFX0wsIE5VTEwpLAo+
IC3CoMKgwqDCoMKgwqDCoFg4Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKFJPQ0tFVExBS0UsIE5V
TEwpLAo+IC3CoMKgwqDCoMKgwqDCoFg4Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKFRJR0VSTEFL
RSwgTlVMTCksCj4gLcKgwqDCoMKgwqDCoMKgWDg2X01BVENIX0lOVEVMX0ZBTTZfTU9ERUwoVElH
RVJMQUtFX0wsIE5VTEwpLAo+IC3CoMKgwqDCoMKgwqDCoFg4Nl9NQVRDSF9JTlRFTF9GQU02X01P
REVMKEFMREVSTEFLRSwgTlVMTCksCj4gLcKgwqDCoMKgwqDCoMKgWDg2X01BVENIX0lOVEVMX0ZB
TTZfTU9ERUwoQUxERVJMQUtFX0wsIE5VTEwpLAo+IC3CoMKgwqDCoMKgwqDCoFg4Nl9NQVRDSF9J
TlRFTF9GQU02X01PREVMKFJBUFRPUkxBS0UsIE5VTEwpLAo+IC3CoMKgwqDCoMKgwqDCoFg4Nl9N
QVRDSF9JTlRFTF9GQU02X01PREVMKFJBUFRPUkxBS0VfUCwgTlVMTCksCj4gLcKgwqDCoMKgwqDC
oMKgWDg2X01BVENIX0lOVEVMX0ZBTTZfTU9ERUwoUkFQVE9STEFLRV9TLCBOVUxMKSwKPiAtwqDC
oMKgwqDCoMKgwqBYODZfTUFUQ0hfSU5URUxfRkFNNl9NT0RFTChNRVRFT1JMQUtFLCBOVUxMKSwK
PiAtwqDCoMKgwqDCoMKgwqBYODZfTUFUQ0hfSU5URUxfRkFNNl9NT0RFTChNRVRFT1JMQUtFX0ws
IE5VTEwpLAo+IC3CoMKgwqDCoMKgwqDCoFg4Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKEFSUk9X
TEFLRSwgTlVMTCksCj4gLcKgwqDCoMKgwqDCoMKgWDg2X01BVENIX0lOVEVMX0ZBTTZfTU9ERUwo
QVJST1dMQUtFX0gsIE5VTEwpLAo+IC3CoMKgwqDCoMKgwqDCoFg4Nl9NQVRDSF9JTlRFTF9GQU02
X01PREVMKExVTkFSTEFLRV9NLCBOVUxMKSwKPiArwqDCoMKgwqDCoMKgwqBYODZfTUFUQ0hfVkZN
KElOVEVMX0JST0FEV0VMTF9HLMKgwqDCoMKgwqDCoMKgwqBOVUxMKSwKPiArwqDCoMKgwqDCoMKg
wqBYODZfTUFUQ0hfVkZNKElOVEVMX0JST0FEV0VMTF9YLMKgwqDCoMKgwqDCoMKgwqBOVUxMKSwK
PiArwqDCoMKgwqDCoMKgwqBYODZfTUFUQ0hfVkZNKElOVEVMX0JST0FEV0VMTF9ELMKgwqDCoMKg
wqDCoMKgwqBOVUxMKSwKPiArwqDCoMKgwqDCoMKgwqBYODZfTUFUQ0hfVkZNKElOVEVMX1NLWUxB
S0VfWCzCoMKgTlVMTCksCj4gK8KgwqDCoMKgwqDCoMKgWDg2X01BVENIX1ZGTShJTlRFTF9JQ0VM
QUtFX1gswqDCoE5VTEwpLAo+ICvCoMKgwqDCoMKgwqDCoFg4Nl9NQVRDSF9WRk0oSU5URUxfSUNF
TEFLRV9ELMKgwqBOVUxMKSwKPiArwqDCoMKgwqDCoMKgwqBYODZfTUFUQ0hfVkZNKElOVEVMX1NB
UFBISVJFUkFQSURTX1gsIE5VTEwpLAo+ICvCoMKgwqDCoMKgwqDCoFg4Nl9NQVRDSF9WRk0oSU5U
RUxfRU1FUkFMRFJBUElEU19YLCBOVUxMKSwKPiArwqDCoMKgwqDCoMKgwqBYODZfTUFUQ0hfVkZN
KElOVEVMX0tBQllMQUtFLCBOVUxMKSwKPiArwqDCoMKgwqDCoMKgwqBYODZfTUFUQ0hfVkZNKElO
VEVMX0tBQllMQUtFX0wsIE5VTEwpLAo+ICvCoMKgwqDCoMKgwqDCoFg4Nl9NQVRDSF9WRk0oSU5U
RUxfQ09NRVRMQUtFLCBOVUxMKSwKPiArwqDCoMKgwqDCoMKgwqBYODZfTUFUQ0hfVkZNKElOVEVM
X0NPTUVUTEFLRV9MLCBOVUxMKSwKPiArwqDCoMKgwqDCoMKgwqBYODZfTUFUQ0hfVkZNKElOVEVM
X0NBTk5PTkxBS0VfTCwgTlVMTCksCj4gK8KgwqDCoMKgwqDCoMKgWDg2X01BVENIX1ZGTShJTlRF
TF9JQ0VMQUtFLCBOVUxMKSwKPiArwqDCoMKgwqDCoMKgwqBYODZfTUFUQ0hfVkZNKElOVEVMX0lD
RUxBS0VfTCwgTlVMTCksCj4gK8KgwqDCoMKgwqDCoMKgWDg2X01BVENIX1ZGTShJTlRFTF9ST0NL
RVRMQUtFLCBOVUxMKSwKPiArwqDCoMKgwqDCoMKgwqBYODZfTUFUQ0hfVkZNKElOVEVMX1RJR0VS
TEFLRSwgTlVMTCksCj4gK8KgwqDCoMKgwqDCoMKgWDg2X01BVENIX1ZGTShJTlRFTF9USUdFUkxB
S0VfTCwgTlVMTCksCj4gK8KgwqDCoMKgwqDCoMKgWDg2X01BVENIX1ZGTShJTlRFTF9BTERFUkxB
S0UsIE5VTEwpLAo+ICvCoMKgwqDCoMKgwqDCoFg4Nl9NQVRDSF9WRk0oSU5URUxfQUxERVJMQUtF
X0wsIE5VTEwpLAo+ICvCoMKgwqDCoMKgwqDCoFg4Nl9NQVRDSF9WRk0oSU5URUxfUkFQVE9STEFL
RSwgTlVMTCksCj4gK8KgwqDCoMKgwqDCoMKgWDg2X01BVENIX1ZGTShJTlRFTF9SQVBUT1JMQUtF
X1AsIE5VTEwpLAo+ICvCoMKgwqDCoMKgwqDCoFg4Nl9NQVRDSF9WRk0oSU5URUxfUkFQVE9STEFL
RV9TLCBOVUxMKSwKPiArwqDCoMKgwqDCoMKgwqBYODZfTUFUQ0hfVkZNKElOVEVMX01FVEVPUkxB
S0UsIE5VTEwpLAo+ICvCoMKgwqDCoMKgwqDCoFg4Nl9NQVRDSF9WRk0oSU5URUxfTUVURU9STEFL
RV9MLCBOVUxMKSwKPiArwqDCoMKgwqDCoMKgwqBYODZfTUFUQ0hfVkZNKElOVEVMX0FSUk9XTEFL
RSwgTlVMTCksCj4gK8KgwqDCoMKgwqDCoMKgWDg2X01BVENIX1ZGTShJTlRFTF9BUlJPV0xBS0Vf
SCwgTlVMTCksCj4gK8KgwqDCoMKgwqDCoMKgWDg2X01BVENIX1ZGTShJTlRFTF9MVU5BUkxBS0Vf
TSwgTlVMTCksCj4gwqDCoMKgwqDCoMKgwqDCoHt9Cj4gwqB9Owo+IMKgTU9EVUxFX0RFVklDRV9U
QUJMRSh4ODZjcHUsIGludGVsX3VuY29yZV9jcHVfaWRzKTsKCg==


