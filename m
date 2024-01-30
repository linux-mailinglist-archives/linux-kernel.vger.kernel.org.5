Return-Path: <linux-kernel+bounces-45401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F87D842FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8E92858AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECD478B7B;
	Tue, 30 Jan 2024 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ef6fvhgU"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C290C78677
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706653866; cv=none; b=t5tmKTIxjB8m6RqMpOAt5JKPXiBf2D/j775m+rQ788QaIxp6WlQdphcc09n2hqL3rUcwut/0dABhOvY2woJiKVTHRYKs391Ps3JqRtgUl6Rl687rCT8Ex5hZrayAzSJStqljGAB5Mu6+15ta7PDME8Q2aPfYzyFilDG3e7KB+Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706653866; c=relaxed/simple;
	bh=cAKvGryUinyz1i8lgKU0z1MgcOvnbLrOQy0WnM5M21c=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=K/drdG7IndnLsPufWv5ebTV+BmhDdLBD6631q5Uu7dyD5qhUrb5rYT3DjzcIu5Xee7xCwO7QoYd0bJNJ/TC0+IL72aOSOX8T1SVS6qfPUEQRU42gjme/NR+oNNBRFje94QamqvSD036wyC3C7Ff6/7FiWyKOMEXML/xdvXGBIgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ef6fvhgU; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso56425739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1706653862; x=1707258662; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nsdCrxbJMkHWE2IVMxvoEl76crbHFHMA88l9bGpCqFs=;
        b=ef6fvhgUK7CQj/75J5XzjB0Ywb80WrRd5tFVoXjDKVLLrZLQOr3trZ/oOwa/P5evWD
         KYtxCUgHe5qkpJSMueGeScjQREfO8xuN2RnfLoBuDzx+dq2JrNe040yaTaHhF1sU7dLl
         4EU94Sxms6rzlZBqTniZcoScl8o1yYkpL1btQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706653862; x=1707258662;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsdCrxbJMkHWE2IVMxvoEl76crbHFHMA88l9bGpCqFs=;
        b=h2lTsLW9dHVEgHjFKlz21dBBfOIWvNuT7AjDAAtpSUfrJcOf6Ar5vtVgLlRqatJKEd
         VWvTCJB0j5rFc1P+XJAGKSaGejxbAYX9SvGueks3OPlEe0HWIi5ooHwinz/xxL1qa4KI
         6w4eix+Lf8/ytv7xsJR00aD0POkRhr1470vDahzCu4pKUfZ4Q/AI4DJw7PFUmR5cF6n/
         U5IRW5f/Y4PbjP83S6PN8A7MzU0lZs4x7+WiTBPr1q3lM0LwCdSw6HsiWygIGrRbh9hX
         qm3nCn1ud2kGKwjYWF2Zli3jvNoH4rU2XQ8NCqpwhyDDrikgs2gylyn8l5gUZMMAdUwG
         D0qg==
X-Forwarded-Encrypted: i=0; AJvYcCU7JyHNWLNLO9Rh4zoQLbR2S40fxXChmU6nzldL3N98X70/resNhAuFsttxKUhGTsOJB5bKDuIET7tCXO/caECn4g+dJq3smjxb1w12
X-Gm-Message-State: AOJu0YzHdvJq7geYUitzXca8YMB0GZ78L1YNWzwnojyeg07mYs+QXb+h
	LQOsFXYinLaUtFGQ6YNMz/BELcxv8F9INmgY1vxWiGfOT9BnCzIINcuJxFRsbL0=
X-Google-Smtp-Source: AGHT+IF1vQy2Moya+1fys4dh0OcNnLiOb7VAakaVWLCUIDB2G7SdKboB08Vj1moYDJ5TQz2Ic2TVFg==
X-Received: by 2002:a6b:c8d0:0:b0:7bc:207d:5178 with SMTP id y199-20020a6bc8d0000000b007bc207d5178mr11750991iof.2.1706653861907;
        Tue, 30 Jan 2024 14:31:01 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id l14-20020a056638220e00b0046e1f0f6d92sm2481719jas.76.2024.01.30.14.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 14:31:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------Fay6sEh9uibk9x2D1vTAvykA"
Message-ID: <697a06c6-03a7-4939-9821-392239b3d5b2@linuxfoundation.org>
Date: Tue, 30 Jan 2024 15:31:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Brendan Higgins <brendanhiggins@google.com>,
 David Gow <davidgow@google.com>, shuah <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit fixes update for Linux 6.8-rc3

This is a multi-part message in MIME format.
--------------Fay6sEh9uibk9x2D1vTAvykA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit fixes update for Linux 6.8-rc3.

This kunit fixes update for Linux 6.8-rc3 consists of NULL vs IS_ERR()
bug fixes, documentation update, MAINTAINERS file update to add
Rae Moar as a reviewer, and a fix to run test suites only after module
initialization completes.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

   Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.8-rc3

for you to fetch changes up to 1a9f2c776d1416c4ea6cb0d0b9917778c41a1a7d:

   Documentation: KUnit: Update the instructions on how to test static functions (2024-01-22 07:59:03 -0700)

----------------------------------------------------------------
linux_kselftest-kunit-fixes-6.8-rc3

This kunit fixes update for Linux 6.8-rc3 consists of NULL vs IS_ERR()
bug fixes, documentation update, MAINTAINERS file update to add
Rae Moar as a reviewer, and a fix to run test suites only after module
initialization completes.

----------------------------------------------------------------
Arthur Grillo (1):
       Documentation: KUnit: Update the instructions on how to test static functions

Dan Carpenter (2):
       kunit: Fix a NULL vs IS_ERR() bug
       kunit: device: Fix a NULL vs IS_ERR() check in init()

David Gow (1):
       MAINTAINERS: kunit: Add Rae Moar as a reviewer

Marco Pagani (1):
       kunit: run test suites only after module initialization completes

  Documentation/dev-tools/kunit/usage.rst | 19 +++++++++++++++++--
  MAINTAINERS                             |  1 +
  lib/kunit/device.c                      |  4 ++--
  lib/kunit/executor.c                    |  4 ++++
  lib/kunit/kunit-test.c                  |  2 +-
  lib/kunit/test.c                        | 14 +++++++++++---
  6 files changed, 36 insertions(+), 8 deletions(-)
----------------------------------------------------------------
--------------Fay6sEh9uibk9x2D1vTAvykA
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-kunit-fixes-6.8-rc3.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-kunit-fixes-6.8-rc3.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2t1bml0L3VzYWdlLnJzdCBi
L0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2t1bml0L3VzYWdlLnJzdAppbmRleCBhOWVmYWI1
MGVlZDguLjIyOTU1ZDU2YjM3OSAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXYtdG9v
bHMva3VuaXQvdXNhZ2UucnN0CisrKyBiL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2t1bml0
L3VzYWdlLnJzdApAQCAtNjcxLDggKzY3MSwyMyBAQCBUZXN0aW5nIFN0YXRpYyBGdW5jdGlv
bnMKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogCiBJZiB3ZSBkbyBub3Qgd2FudCB0byBl
eHBvc2UgZnVuY3Rpb25zIG9yIHZhcmlhYmxlcyBmb3IgdGVzdGluZywgb25lIG9wdGlvbiBp
cyB0bwotY29uZGl0aW9uYWxseSBgYCNpbmNsdWRlYGAgdGhlIHRlc3QgZmlsZSBhdCB0aGUg
ZW5kIG9mIHlvdXIgLmMgZmlsZS4gRm9yCi1leGFtcGxlOgorY29uZGl0aW9uYWxseSBleHBv
cnQgdGhlIHVzZWQgc3ltYm9sLiBGb3IgZXhhbXBsZToKKworLi4gY29kZS1ibG9jazo6IGMK
KworCS8qIEluIG15X2ZpbGUuYyAqLworCisJVklTSUJMRV9JRl9LVU5JVCBpbnQgZG9faW50
ZXJlc3RpbmdfdGhpbmcoKTsKKwlFWFBPUlRfU1lNQk9MX0lGX0tVTklUKGRvX2ludGVyZXN0
aW5nX3RoaW5nKTsKKworCS8qIEluIG15X2ZpbGUuaCAqLworCisJI2lmIElTX0VOQUJMRUQo
Q09ORklHX0tVTklUKQorCQlpbnQgZG9faW50ZXJlc3RpbmdfdGhpbmcodm9pZCk7CisJI2Vu
ZGlmCisKK0FsdGVybmF0aXZlbHksIHlvdSBjb3VsZCBjb25kaXRpb25hbGx5IGBgI2luY2x1
ZGVgYCB0aGUgdGVzdCBmaWxlIGF0IHRoZSBlbmQgb2YKK3lvdXIgLmMgZmlsZS4gRm9yIGV4
YW1wbGU6CiAKIC4uIGNvZGUtYmxvY2s6OiBjCiAKZGlmZiAtLWdpdCBhL01BSU5UQUlORVJT
IGIvTUFJTlRBSU5FUlMKaW5kZXggOGQxMDUyZmE2YTY5Li4zNTRkOTkzYmMyY2YgMTAwNjQ0
Ci0tLSBhL01BSU5UQUlORVJTCisrKyBiL01BSU5UQUlORVJTCkBAIC0xMTcyNCw2ICsxMTcy
NCw3IEBAIEY6CWZzL3NtYi9zZXJ2ZXIvCiBLRVJORUwgVU5JVCBURVNUSU5HIEZSQU1FV09S
SyAoS1VuaXQpCiBNOglCcmVuZGFuIEhpZ2dpbnMgPGJyZW5kYW5oaWdnaW5zQGdvb2dsZS5j
b20+CiBNOglEYXZpZCBHb3cgPGRhdmlkZ293QGdvb2dsZS5jb20+CitSOglSYWUgTW9hciA8
cm1vYXJAZ29vZ2xlLmNvbT4KIEw6CWxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmcK
IEw6CWt1bml0LWRldkBnb29nbGVncm91cHMuY29tCiBTOglNYWludGFpbmVkCmRpZmYgLS1n
aXQgYS9saWIva3VuaXQvZGV2aWNlLmMgYi9saWIva3VuaXQvZGV2aWNlLmMKaW5kZXggZjUz
NzEyODdiMzc1Li4wNzRjNmRkMmUzNmEgMTAwNjQ0Ci0tLSBhL2xpYi9rdW5pdC9kZXZpY2Uu
YworKysgYi9saWIva3VuaXQvZGV2aWNlLmMKQEAgLTQ1LDggKzQ1LDggQEAgaW50IGt1bml0
X2J1c19pbml0KHZvaWQpCiAJaW50IGVycm9yOwogCiAJa3VuaXRfYnVzX2RldmljZSA9IHJv
b3RfZGV2aWNlX3JlZ2lzdGVyKCJrdW5pdCIpOwotCWlmICgha3VuaXRfYnVzX2RldmljZSkK
LQkJcmV0dXJuIC1FTk9NRU07CisJaWYgKElTX0VSUihrdW5pdF9idXNfZGV2aWNlKSkKKwkJ
cmV0dXJuIFBUUl9FUlIoa3VuaXRfYnVzX2RldmljZSk7CiAKIAllcnJvciA9IGJ1c19yZWdp
c3Rlcigma3VuaXRfYnVzX3R5cGUpOwogCWlmIChlcnJvcikKZGlmZiAtLWdpdCBhL2xpYi9r
dW5pdC9leGVjdXRvci5jIGIvbGliL2t1bml0L2V4ZWN1dG9yLmMKaW5kZXggNzE3Yjk1OTkw
MzZiLi42ODlmZmYyYjJiMTAgMTAwNjQ0Ci0tLSBhL2xpYi9rdW5pdC9leGVjdXRvci5jCisr
KyBiL2xpYi9rdW5pdC9leGVjdXRvci5jCkBAIC0xNDYsNiArMTQ2LDEwIEBAIHZvaWQga3Vu
aXRfZnJlZV9zdWl0ZV9zZXQoc3RydWN0IGt1bml0X3N1aXRlX3NldCBzdWl0ZV9zZXQpCiAJ
a2ZyZWUoc3VpdGVfc2V0LnN0YXJ0KTsKIH0KIAorLyoKKyAqIEZpbHRlciBhbmQgcmVhbGxv
Y2F0ZSB0ZXN0IHN1aXRlcy4gTXVzdCByZXR1cm4gdGhlIGZpbHRlcmVkIHRlc3Qgc3VpdGVz
IHNldAorICogYWxsb2NhdGVkIGF0IGEgdmFsaWQgdmlydHVhbCBhZGRyZXNzIG9yIE5VTEwg
aW4gY2FzZSBvZiBlcnJvci4KKyAqLwogc3RydWN0IGt1bml0X3N1aXRlX3NldAoga3VuaXRf
ZmlsdGVyX3N1aXRlcyhjb25zdCBzdHJ1Y3Qga3VuaXRfc3VpdGVfc2V0ICpzdWl0ZV9zZXQs
CiAJCSAgICBjb25zdCBjaGFyICpmaWx0ZXJfZ2xvYiwKZGlmZiAtLWdpdCBhL2xpYi9rdW5p
dC9rdW5pdC10ZXN0LmMgYi9saWIva3VuaXQva3VuaXQtdGVzdC5jCmluZGV4IGM0MjU5ZDkx
MDM1Ni4uZjc5ODBlZjIzNmEzIDEwMDY0NAotLS0gYS9saWIva3VuaXQva3VuaXQtdGVzdC5j
CisrKyBiL2xpYi9rdW5pdC9rdW5pdC10ZXN0LmMKQEAgLTcyMCw3ICs3MjAsNyBAQCBzdGF0
aWMgdm9pZCBrdW5pdF9kZXZpY2VfY2xlYW51cF90ZXN0KHN0cnVjdCBrdW5pdCAqdGVzdCkK
IAlsb25nIGFjdGlvbl93YXNfcnVuID0gMDsKIAogCXRlc3RfZGV2aWNlID0ga3VuaXRfZGV2
aWNlX3JlZ2lzdGVyKHRlc3QsICJteV9kZXZpY2UiKTsKLQlLVU5JVF9BU1NFUlRfTk9UX05V
TEwodGVzdCwgdGVzdF9kZXZpY2UpOworCUtVTklUX0FTU0VSVF9OT1RfRVJSX09SX05VTEwo
dGVzdCwgdGVzdF9kZXZpY2UpOwogCiAJLyogQWRkIGFuIGFjdGlvbiB0byB2ZXJpZnkgY2xl
YW51cC4gKi8KIAlkZXZtX2FkZF9hY3Rpb24odGVzdF9kZXZpY2UsIHRlc3RfZGV2X2FjdGlv
biwgJmFjdGlvbl93YXNfcnVuKTsKZGlmZiAtLWdpdCBhL2xpYi9rdW5pdC90ZXN0LmMgYi9s
aWIva3VuaXQvdGVzdC5jCmluZGV4IGY5NWQyMDkzYTBhYS4uMzFhNWE5OTJlNjQ2IDEwMDY0
NAotLS0gYS9saWIva3VuaXQvdGVzdC5jCisrKyBiL2xpYi9rdW5pdC90ZXN0LmMKQEAgLTE3
LDYgKzE3LDcgQEAKICNpbmNsdWRlIDxsaW51eC9wYW5pYy5oPgogI2luY2x1ZGUgPGxpbnV4
L3NjaGVkL2RlYnVnLmg+CiAjaW5jbHVkZSA8bGludXgvc2NoZWQuaD4KKyNpbmNsdWRlIDxs
aW51eC9tbS5oPgogCiAjaW5jbHVkZSAiZGVidWdmcy5oIgogI2luY2x1ZGUgImRldmljZS1p
bXBsLmgiCkBAIC04MDEsMTIgKzgwMiwxOSBAQCBzdGF0aWMgdm9pZCBrdW5pdF9tb2R1bGVf
ZXhpdChzdHJ1Y3QgbW9kdWxlICptb2QpCiAJfTsKIAljb25zdCBjaGFyICphY3Rpb24gPSBr
dW5pdF9hY3Rpb24oKTsKIAorCS8qCisJICogQ2hlY2sgaWYgdGhlIHN0YXJ0IGFkZHJlc3Mg
aXMgYSB2YWxpZCB2aXJ0dWFsIGFkZHJlc3MgdG8gZGV0ZWN0CisJICogaWYgdGhlIG1vZHVs
ZSBsb2FkIHNlcXVlbmNlIGhhcyBmYWlsZWQgYW5kIHRoZSBzdWl0ZSBzZXQgaGFzIG5vdAor
CSAqIGJlZW4gaW5pdGlhbGl6ZWQgYW5kIGZpbHRlcmVkLgorCSAqLworCWlmICghc3VpdGVf
c2V0LnN0YXJ0IHx8ICF2aXJ0X2FkZHJfdmFsaWQoc3VpdGVfc2V0LnN0YXJ0KSkKKwkJcmV0
dXJuOworCiAJaWYgKCFhY3Rpb24pCiAJCV9fa3VuaXRfdGVzdF9zdWl0ZXNfZXhpdChtb2Qt
Pmt1bml0X3N1aXRlcywKIAkJCQkJIG1vZC0+bnVtX2t1bml0X3N1aXRlcyk7CiAKLQlpZiAo
c3VpdGVfc2V0LnN0YXJ0KQotCQlrdW5pdF9mcmVlX3N1aXRlX3NldChzdWl0ZV9zZXQpOwor
CWt1bml0X2ZyZWVfc3VpdGVfc2V0KHN1aXRlX3NldCk7CiB9CiAKIHN0YXRpYyBpbnQga3Vu
aXRfbW9kdWxlX25vdGlmeShzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iLCB1bnNpZ25lZCBs
b25nIHZhbCwKQEAgLTgxNiwxMiArODI0LDEyIEBAIHN0YXRpYyBpbnQga3VuaXRfbW9kdWxl
X25vdGlmeShzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iLCB1bnNpZ25lZCBsb25nIHZhbCwK
IAogCXN3aXRjaCAodmFsKSB7CiAJY2FzZSBNT0RVTEVfU1RBVEVfTElWRToKKwkJa3VuaXRf
bW9kdWxlX2luaXQobW9kKTsKIAkJYnJlYWs7CiAJY2FzZSBNT0RVTEVfU1RBVEVfR09JTkc6
CiAJCWt1bml0X21vZHVsZV9leGl0KG1vZCk7CiAJCWJyZWFrOwogCWNhc2UgTU9EVUxFX1NU
QVRFX0NPTUlORzoKLQkJa3VuaXRfbW9kdWxlX2luaXQobW9kKTsKIAkJYnJlYWs7CiAJY2Fz
ZSBNT0RVTEVfU1RBVEVfVU5GT1JNRUQ6CiAJCWJyZWFrOwo=

--------------Fay6sEh9uibk9x2D1vTAvykA--

