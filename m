Return-Path: <linux-kernel+bounces-125386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E73892527
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E871F23638
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBAB13B7A7;
	Fri, 29 Mar 2024 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZPh41XLi"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14913AA52
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711743596; cv=none; b=IfjCl5rSJr5LQiAI2ODzCoaBOSoL29AxpOi+QyVCLO/2PvWIL/mnXh3XCunDAxD94RMm3jsxX+8WddlEslgiMeZZm2mMC9fYN2ZzUAiAg/kmGNqK05+hckITNxY2oTHfA/Ac2UHkD5A+eqzRWtmzmmSMEwgUIvjB8QTjZx4/YNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711743596; c=relaxed/simple;
	bh=vl+i70ZMCodkAigSW5hho0Ztj2SmfeRNq80IcW3/8ZA=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=b2DdYvZp/vBGDvimbrTo+NvLtPhtNdfytPSQEHcmseHx7meAtEFTwCbEgujUjhK4etRTqosNN1eBQSFF83BbeGOo1SkWrS9OO8R+momHo3is44f7z/D2lSqC6gt8bI6FII4vn4S7ZdsmCPBUsyDXbCWaiAnks3wa381CzYbqrDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZPh41XLi; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3685acaa878so3133355ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711743593; x=1712348393; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=An2c+m0EBVjUyZtfRNWkkg/EmLKM6ADwwn2qcGZufac=;
        b=ZPh41XLino/bd3mlpbAEOsdQJv+egyl50n0re4XEsscXA7SPDK2mFuWIv3BG2IxFnd
         56B7cYDnc4yNaBG48usAjUOzjB0YXpz8OZ1QrnGbkS1BL2G491HFspO5RAwYzJDhp0NY
         fRqNOdFVHYpInmIE8kJpcfXQIEHWwkM/YQIEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711743593; x=1712348393;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=An2c+m0EBVjUyZtfRNWkkg/EmLKM6ADwwn2qcGZufac=;
        b=E/ciGLzgJtdslWwpdsvTL3ZxKFeEPrd/X17MyWXZQQD0VzDoaTcOp2z0PAtvacwZC6
         kwjWUJdV0jZaFILISPVgnjeibPnf2mxcXVeHqiQn8iJ4+Oqv0fLqTyKLud2l/r/1SUkV
         mpeG0SUqpXskqcxTjo1RjhlAQh/kCGlxHTpTuzZvmsD7tQv464v5HB471tO0CbG/JNVh
         YR4Qynx/TRWVon1JqabK8WJqnnHE6Zo4alYNZDbQgmni3HRKl5uu/1xVG0vP6GAU6H5a
         P2DY23puYsn07aVdve+XuTLfC3tG9FGhfkRJhzirhrKfKSL1BrL6cYyom/TeWmp8ilKx
         vrJA==
X-Forwarded-Encrypted: i=1; AJvYcCUfmoJ/FzAs0TRnOXmpXTmUJgyyjbfixmUKyo3M/aWmMezwfZG9HRL2RnmuBkxyL4DgS9rPJ8mQC7rOzHn740NcJTuauPQDWr3UX1sV
X-Gm-Message-State: AOJu0YztNtYtfFCyfJZIpunT9+R41z1WgLhH+Zaz5WqnF9Lqnzz22T6Y
	l6YDlsEgCssyK23c7FstF9n6W5621dfqn1qB/GbmZHM0rEGON2DSxmrXTwZ/C/c=
X-Google-Smtp-Source: AGHT+IFUE0Sf7NoL7vX8ci6ITd6PYpGYErdQvzC4eTqLCCaNA/qbYj/Mkoud1o2JaL29+504kfmRNg==
X-Received: by 2002:a5e:da04:0:b0:7d0:32b0:5764 with SMTP id x4-20020a5eda04000000b007d032b05764mr3331372ioj.0.1711743593467;
        Fri, 29 Mar 2024 13:19:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id p23-20020a6bfa17000000b007cbf94d8698sm1223132ioh.4.2024.03.29.13.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 13:19:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------OWEC03me0GRkyfQ0OjAfR75D"
Message-ID: <c9b1f203-a8b6-479f-86c2-49d6aac378bf@linuxfoundation.org>
Date: Fri, 29 Mar 2024 14:19:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 6.9-rc2

This is a multi-part message in MIME format.
--------------OWEC03me0GRkyfQ0OjAfR75D
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following kselftest fixes update for Linux 6.9rc2.

This kselftest fixes update for Linux 6.9-rc2 consists of fixes
to seccomp and ftrace tests and a change to add config file for
dmabuf-heap test to increase coverage.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 4cece764965020c22cff7665b18a012006359095:

   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-fixes-6.9-rc2

for you to fetch changes up to 224fe424c356cb5c8f451eca4127f32099a6f764:

   selftests: dmabuf-heap: add config file for the test (2024-03-29 13:57:14 -0600)

----------------------------------------------------------------
linux_kselftest-fixes-6.9-rc2

This kselftest fixes update for Linux 6.9-rc2 consists of fixes
to seccomp and ftrace tests and a change to add config file for
dmabuf-heap test to increase coverage.

----------------------------------------------------------------
Mark Brown (1):
       selftests/seccomp: Try to fit runtime of benchmark into timeout

Mark Rutland (1):
       selftests/ftrace: Fix event filter target_func selection

Muhammad Usama Anjum (1):
       selftests: dmabuf-heap: add config file for the test

  tools/testing/selftests/dmabuf-heaps/config                           | 3 +++
  tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc | 2 +-
  tools/testing/selftests/seccomp/settings                              | 2 +-
  3 files changed, 5 insertions(+), 2 deletions(-)
  create mode 100644 tools/testing/selftests/dmabuf-heaps/config
----------------------------------------------------------------
--------------OWEC03me0GRkyfQ0OjAfR75D
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-fixes-6.9-rc2.diff"
Content-Disposition: attachment; filename="linux_kselftest-fixes-6.9-rc2.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2RtYWJ1Zi1oZWFwcy9jb25m
aWcgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9kbWFidWYtaGVhcHMvY29uZmlnCm5ldyBm
aWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uYmUwOTFmMWNkZmEwCi0tLSAv
ZGV2L251bGwKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZG1hYnVmLWhlYXBzL2Nv
bmZpZwpAQCAtMCwwICsxLDMgQEAKK0NPTkZJR19ETUFCVUZfSEVBUFM9eQorQ09ORklHX0RN
QUJVRl9IRUFQU19TWVNURU09eQorQ09ORklHX0RSTV9WR0VNPXkKZGlmZiAtLWdpdCBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZmlsdGVyL2V2ZW50LWZpbHRl
ci1mdW5jdGlvbi50YyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQv
ZmlsdGVyL2V2ZW50LWZpbHRlci1mdW5jdGlvbi50YwppbmRleCAyZGU3YzYxZDFhZTMuLjNm
NzRjMDljNTZiNiAxMDA2NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvZnRyYWNl
L3Rlc3QuZC9maWx0ZXIvZXZlbnQtZmlsdGVyLWZ1bmN0aW9uLnRjCisrKyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL2Z0cmFjZS90ZXN0LmQvZmlsdGVyL2V2ZW50LWZpbHRlci1mdW5j
dGlvbi50YwpAQCAtMjQsNyArMjQsNyBAQCBlY2hvIDAgPiBldmVudHMvZW5hYmxlCiBlY2hv
ICJHZXQgdGhlIG1vc3QgZnJlcXVlbnRseSBjYWxsaW5nIGZ1bmN0aW9uIgogc2FtcGxlX2V2
ZW50cwogCi10YXJnZXRfZnVuYz1gY3V0IC1kOiAtZjMgdHJhY2UgfCBzZWQgJ3MvY2FsbF9z
aXRlPVwoW14rXSpcKSsweC4qL1wxLycgfCBzb3J0IHwgdW5pcSAtYyB8IHNvcnQgfCB0YWls
IC1uIDEgfCBzZWQgJ3MvXlsgMC05XSovLydgCit0YXJnZXRfZnVuYz1gY2F0IHRyYWNlIHwg
Z3JlcCAtbyAnY2FsbF9zaXRlPVwoW14rXSpcKScgfCBzZWQgJ3MvY2FsbF9zaXRlPS8vJyB8
IHNvcnQgfCB1bmlxIC1jIHwgc29ydCB8IHRhaWwgLW4gMSB8IHNlZCAncy9eWyAwLTldKi8v
J2AKIGlmIFsgLXogIiR0YXJnZXRfZnVuYyIgXTsgdGhlbgogICAgIGV4aXRfZmFpbAogZmkK
ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3NlY2NvbXAvc2V0dGluZ3Mg
Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9zZWNjb21wL3NldHRpbmdzCmluZGV4IDYwOTFi
NDVkMjI2Yi4uYTk1M2M5NmFhMTZlIDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9zZWNjb21wL3NldHRpbmdzCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Nl
Y2NvbXAvc2V0dGluZ3MKQEAgLTEgKzEgQEAKLXRpbWVvdXQ9MTIwCit0aW1lb3V0PTE4MAo=


--------------OWEC03me0GRkyfQ0OjAfR75D--

