Return-Path: <linux-kernel+bounces-133772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C57789A870
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 04:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5F35B229D0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CCF11CAF;
	Sat,  6 Apr 2024 02:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="aT5HgZEf"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9E18C05
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712370099; cv=none; b=k57tafSFQgY5spu4XL53GCICXc0wVPxv5nTJurerMvFrChBN6tqUrHUmhFn6IRuzx//gMdRy4Z2enFAxBTXzhg6d7QaD8TXlbMNOkrPIB9Fqqz4e+GnLS8nrpgO6i/+TT/lopSbkxOqel5ghdnSoHUyB1cQBnAPWPLPKmd+byJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712370099; c=relaxed/simple;
	bh=MpSNT92oR3LiNiss4k+Y22DfN1U8viezGuGnfE9tE1A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NeRVLxAIHWE/zynn0InzO8kddbsK8w+5fIoiexGHuwpNdRxOKEYvcUwA0PacBYhmWQPodxr7gYiZWfMrMmJKgJ4Tta7smFdr21X2gwj54snGJkBpajy8NnzEiojCzL7NrtbuVn/9f5USQOdM6hsZndL2LrI/Xqu8kFxXvDd7VVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=aT5HgZEf; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712370049; x=1712974849; i=efault@gmx.de;
	bh=MpSNT92oR3LiNiss4k+Y22DfN1U8viezGuGnfE9tE1A=;
	h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:
	 References;
	b=aT5HgZEfwr8sDtbGFd8y9HlPymhDJ57zzFzF/tRKGTuv05gfeihlTWHFWofOfFU5
	 B9lN2vPWLPJjcCSqXZ6c2ndnwaBeEDaec/RFw4VrBS5P3GreT+VrhpgDB+5PyXNzN
	 AOp+eeNfGx7/OUg9mAeJe2rv29QvEoDP1U1JbE8w4X/ttle1hMVzy3qB3Dpp7farJ
	 FgC+Yb28wodPSw0zV87ToNQBw1Jmth9oV8tmKZC8tvDnOQHCef+gr6KHk/WCD+Qp6
	 zCKMZ4EtsRioxqJ4s5otXcR2d9zQIzypT/wWxBEil63C9otpVBqz9a52bi17G5xeB
	 Zv9d/DklqhoDeVEihw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.51.26]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26rD-1rvPa543o1-002W81; Sat, 06
 Apr 2024 04:20:49 +0200
Message-ID: <6c1127ff3b1718585bcb6374fb444b15b753cacb.camel@gmx.de>
Subject: Re: [RFC][PATCH 05/10] sched/fair: Unify pick_{,next_}_task_fair()
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,  rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com,  vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, wuyun.abel@bytedance.com, tglx@linutronix.de
Date: Sat, 06 Apr 2024 04:20:44 +0200
In-Reply-To: <20240405110010.239280675@infradead.org>
References: <20240405102754.435410987@infradead.org>
	 <20240405110010.239280675@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:E76SBl7P+Sq9GquZFOhwK9bFEh1h5nf54QM1xHfYgS+4PZTETg4
 8htNfJYaHsD8OVmQNx2FOBzO9vbrHgfVk7bmiH3mJStOBkQeW5JRmaQOcvzSCrTigBvBA61
 fgCv1Q8C9zv30NoXYfXfPfmUXCzb/ulfPZ76unzFuG+VlAoY2J6MadQBd54IIH8RfJqjhGG
 sBP2ivtP2/CBhS1U8jh3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aBRqwxBEZKI=;BOdvI+0GGoSHGplP8BAFTdPI99Z
 urgTl/1xXLjiPTO6rxZ64CEv08+4AAh6R5wvc6Z3T9gobCyqEHpBNDjhIsjWDw6H/WH7JZxck
 hJ63sSEmyWT/EM6fQl6o73KBtM0vgDFSwGfPwbxL0PHQ54BEQfGkWpJ4ajvy3AhnRESkcy5rP
 K9sf1C17YD0te9NtHuVJbM16KoHSLA0uC7b9zw/Om47JYRNxwT8tj96dRcU8kX9akjtfmy8Ix
 miI5DQ+dzZOAM46J9xz6U4Mn+Ilhh28gc4Gt4uKOo9VF1YiSLD++mO+0+hq+avO8TER/Pfrkg
 kPZM+yj2gbVcLXBAgg9qhD9aY0Jx2KDh7xveIi21Nyn9Cfof/DzSyGaOCgH89hSryQq/PYefb
 ga3w1irfBmTLljlW7+94c33ejVqvF5lvjl4hICr722T3YQg66ETM57L3i3jOzdCKNt+WpDZGc
 shG8vJc25jzJLUA1dXWNwM5Je9GX+Kmq6xA2ddxALMohRf+F1Ts3wiAkFxvtPWsM3bO5aaCdA
 D5gLC4dO7sQdogc4kJ5Z6ywJdkBs/SFiejwiFmXK4iKvn/N94vB3sVDs4BFIQC9oL0WxCZRum
 yIGYrF3eqzEx2tBLK+HqFlW/708N6QTChagN/lNDUHkymX6uLd+h/3bWAL5q/wjEmkyiCzZd4
 Mv0mI21dA25YYJM0UEMBTzMnQ7uM1qZipFjJHiDPmpyvKcTh8a46LlXyA+N32gXL/CJrXtkFy
 w63shD3XBlgEaRaaFQQMbu2OrPfNIkiIDZJkN/sBF0OhYVMDwd3VheOeMP2IrCKcy9QoWKZcV
 Rn3TdvwxJIGG497h50vzDMBHyFCGTTTP4ApwJeJjRLpkY=

R3JlZXRpbmdzIChnb29kIHRvIHNlZSB5b3UgYmFjaykuDQoNCk9uIEZyaSwgMjAyNC0wNC0wNSBh
dCAxMjoyNyArMDIwMCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+IEBAIC04NDQwLDE5ICs4NDM5
LDIwIEBAIHN0YXRpYyBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnBpY2tfdGFza19mYWkNCj4gwqANCj4g
wqDCoMKgwqDCoMKgwqDCoHJldHVybiB0YXNrX29mKHNlKTsNCj4gwqB9DQo+IC0jZW5kaWYNCj4g
wqANCj4gwqBzdHJ1Y3QgdGFza19zdHJ1Y3QgKg0KPiDCoHBpY2tfbmV4dF90YXNrX2ZhaXIoc3Ry
dWN0IHJxICpycSwgc3RydWN0IHRhc2tfc3RydWN0ICpwcmV2LCBzdHJ1Y3QgcnFfZmxhZ3MgKnJm
KQ0KPiDCoHsNCj4gLcKgwqDCoMKgwqDCoMKgc3RydWN0IGNmc19ycSAqY2ZzX3JxID0gJnJxLT5j
ZnM7DQo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qgc2NoZWRfZW50aXR5ICpzZTsNCj4gwqDCoMKg
wqDCoMKgwqDCoHN0cnVjdCB0YXNrX3N0cnVjdCAqcDsNCj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0
IGNmc19ycSAqY2ZzX3JxOw0KPiDCoMKgwqDCoMKgwqDCoMKgaW50IG5ld190YXNrczsNCj4gwqAN
Cj4gwqBhZ2FpbjoNCj4gLcKgwqDCoMKgwqDCoMKgaWYgKCFzY2hlZF9mYWlyX3J1bm5hYmxlKHJx
KSkNCj4gK8KgwqDCoMKgwqDCoMKgcCA9IHBpY2tfdGFza19mYWlyKHJxKTsNCj4gK8KgwqDCoMKg
wqDCoMKgaWYgKCFwKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gaWRs
ZTsNCj4gK8KgwqDCoMKgwqDCoMKgc2UgPSAmcC0+c2U7DQo+IMKgDQo+IMKgI2lmZGVmIENPTkZJ
R19GQUlSX0dST1VQX1NDSEVEDQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIXByZXYgfHwgcHJldi0+
c2NoZWRfY2xhc3MgIT0gJmZhaXJfc2NoZWRfY2xhc3MpDQoNClRob3NlIHdobyBkb2RnZSBHUk9V
UF9TQ0hFRCBvdmVyaGVhZCByZWNlaXZlIGEgc2hpbnkgbmV3IHVudXNlZCB2YXJpYWJsZSB3YXJu
aW5nLg0KDQoJLU1pa2UNCg==

