Return-Path: <linux-kernel+bounces-34839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91B1838827
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B151F21E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C871552F73;
	Tue, 23 Jan 2024 07:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kj8Kfumc"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843D356768
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705995765; cv=none; b=Sj8PJXoZctlL7ZkC99SV1SYRV1U7oNfrMYn0CLy0QWYD6Fo2HMUJJ7fmFL/8qcnT0kSJGzzvXWIkRzukuY1oyqGa3iSfyMhfXPOafG6rRr6oExg1jIb399NFgdaS1wfUgBwLBysXNmSfmdoNdMsW1XuRwgixC23332ae/leOr7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705995765; c=relaxed/simple;
	bh=fWVdAFi8tqkVEPHMLL7aLJ5rxCKSE6trIkaFQGg66nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dg3dS1Bhg4TkR/SYk3Gb6cv4cTiFXEKnqeldNAO3zgMf2bBcUwjxY8jOaugSCyzTSggTbc6IdVz3hBZqNv/Gy77+zVuM0m216dE+gZ9Af7JGK0nYQIJxz1swX5b4K9ifuvELciSVpW8I4FNLX+CntLHDIKSlg2aPAIRKpYymv5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kj8Kfumc; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a271a28aeb4so423905566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 23:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705995763; x=1706600563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wZzIeT2Z5wGL0rXRJX/Ydbtl6mnZkEArBg3h/e5jiwQ=;
        b=Kj8Kfumc5CNR+u6BFctOBLQfvVBcUeK30eHhFv6YSop4idtrB4CSe1cbkQwMQPx/dk
         EZCNQlyeC45vM8Up0Oj2ZxiMnNCML+Q1uiSEq+CGvb+1xoIg3KzvAi2A4iOGkznFTKCT
         1wZJzIiHZvSvZFKHXjDyiynln2fsGxjfj60KTPMJz7xarnl2ffskzdBiijWxvm89a6c7
         DjlEPT2fZUllQ7RYJKCPfRS13FcPddiynKZoZiHFw+m+28Q024inZm5TTan791JcYwg1
         eyZkJZLNi5TU35xDZLSzmDBQhrvJFxd9wh836Mj7Z6jIBuxkZpgi3oCV22Sp3tAPrtuw
         +TsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705995763; x=1706600563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZzIeT2Z5wGL0rXRJX/Ydbtl6mnZkEArBg3h/e5jiwQ=;
        b=O3KK5dvreHkalK6kza5fxmmkfYAZRL0km0hKohQTIWDQ5FKoJFZrR9bmaIx8BB3t2o
         asByGgkuroCGAh74eJXrVhSuM6YyIzIyAbBRvQtckrP1SPEqP4FCW6IGnZkmnZ1ZGPUB
         oEyQoAavd5FIhogN/2rUZg7e3nJD6vy2uSUUOzDsCZIXeVCjoM1DH7S5Y21srt0PJ62/
         DvxyKGnria4a/gE29wcB3ELp0eZ/YiLJIn05I+GZmNym8mz0wZJXbDofyM4h4cPDdjXa
         6ikOtE83F8/pr4WOTg/No2kQpFAGRaHrbI+36Mt//ILFisq3Ed1LHIWXQkB8Vcq3RoMB
         SvDg==
X-Gm-Message-State: AOJu0Ywwpt+JT1qVwn2yQCtBSclKkC/Q7LYsI/qFBFIYTpPODk20onnO
	/bFE6M6ZqwpPWhnRKy2eH+2c+K0XugqSbya8gS2Kf6XTcy6+3cw+Ta2MMjCVYpKluaViFRQKK8q
	k+eZ/5MxU/YDuALl/xpGWyHfCb1nnojSGxkvC
X-Google-Smtp-Source: AGHT+IGNX9ulSeeQIbUyGQNVQY4Czahak4z9LGEomH0AJ2xc+UCctfiizqZinfYpBy7MeHaPDFyWXUkPe40oq1O2sdk=
X-Received: by 2002:a17:906:c9d5:b0:a27:be67:1743 with SMTP id
 hk21-20020a170906c9d500b00a27be671743mr2574733ejb.40.1705995762578; Mon, 22
 Jan 2024 23:42:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401221624.cb53a8ca-oliver.sang@intel.com> <CAJD7tka0o+jn3UkXB+ZfZvRw1v+KysJbaGQvJdHcSmAhYC5TQA@mail.gmail.com>
 <Za9pB928KjSORPw+@xsang-OptiPlex-9020>
In-Reply-To: <Za9pB928KjSORPw+@xsang-OptiPlex-9020>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 22 Jan 2024 23:42:04 -0800
Message-ID: <CAJD7tkYtKdLccKbFVoVo9DH8VtHHAXNMEz5D-Ww5jHhDy-QxbA@mail.gmail.com>
Subject: Re: [linus:master] [mm] 8d59d2214c: vm-scalability.throughput -36.6% regression
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, Shakeel Butt <shakeelb@google.com>, 
	Chris Li <chrisl@kernel.org>, Greg Thelen <gthelen@google.com>, 
	Ivan Babrou <ivan@cloudflare.com>, Michal Hocko <mhocko@kernel.org>, 
	Michal Koutny <mkoutny@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Waiman Long <longman@redhat.com>, Wei Xu <weixugc@google.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, ying.huang@intel.com, feng.tang@intel.com, 
	fengwei.yin@intel.com
Content-Type: multipart/mixed; boundary="0000000000006ba232060f9817a0"

--0000000000006ba232060f9817a0
Content-Type: text/plain; charset="UTF-8"

> > Oliver, would you be able to test if the attached patch helps? It's
> > based on 8d59d2214c236.
>
> the patch failed to compile:
>
> build_errors:
>   - "mm/memcontrol.c:731:38: error: 'x' undeclared (first use in this function)"

Apologizes, apparently I sent the patch with some pending diff in my
tree that I hadn't committed. Please find a fixed patch attached.

Thanks.

--0000000000006ba232060f9817a0
Content-Type: application/octet-stream; 
	name="0001-mm-memcg-optimize-parent-iteration-in-memcg_rstat_up.patch"
Content-Disposition: attachment; 
	filename="0001-mm-memcg-optimize-parent-iteration-in-memcg_rstat_up.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lrq1so3z0>
X-Attachment-Id: f_lrq1so3z0

RnJvbSAxYjAwYjRlMGJiYzIxNWZjZWJiOWQzZDQ1ZTVkNjMxMzViN2I3ZTg5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlhaG1lZEBnb29nbGUuY29tPgpE
YXRlOiBNb24sIDIyIEphbiAyMDI0IDIxOjM1OjI5ICswMDAwClN1YmplY3Q6IFtQQVRDSF0gbW06
IG1lbWNnOiBvcHRpbWl6ZSBwYXJlbnQgaXRlcmF0aW9uIGluIG1lbWNnX3JzdGF0X3VwZGF0ZWQo
KQoKU2lnbmVkLW9mZi1ieTogWW9zcnkgQWhtZWQgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4KLS0t
CiBtbS9tZW1jb250cm9sLmMgfCA0NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvbW0vbWVtY29udHJvbC5jIGIvbW0vbWVtY29udHJvbC5jCmlu
ZGV4IGM1YWEwYzJjYjY4YjIuLmQ2YTlkNmRhZDJmMDAgMTAwNjQ0Ci0tLSBhL21tL21lbWNvbnRy
b2wuYworKysgYi9tbS9tZW1jb250cm9sLmMKQEAgLTYzNCw2ICs2MzQsMTAgQEAgc3RydWN0IG1l
bWNnX3Ztc3RhdHNfcGVyY3B1IHsKIAogCS8qIFN0YXRzIHVwZGF0ZXMgc2luY2UgdGhlIGxhc3Qg
Zmx1c2ggKi8KIAl1bnNpZ25lZCBpbnQJCXN0YXRzX3VwZGF0ZXM7CisKKwkvKiBDYWNoZWQgcG9p
bnRlcnMgZm9yIGZhc3QgdXBkYXRlcyBpbiBtZW1jZ19yc3RhdF91cGRhdGVkKCkgKi8KKwlzdHJ1
Y3QgbWVtY2dfdm1zdGF0c19wZXJjcHUJKnBhcmVudDsKKwlzdHJ1Y3QgbWVtY2dfdm1zdGF0cwkJ
KnZtc3RhdHM7CiB9OwogCiBzdHJ1Y3QgbWVtY2dfdm1zdGF0cyB7CkBAIC02OTgsMzYgKzcwMiwz
NSBAQCBzdGF0aWMgdm9pZCBtZW1jZ19zdGF0c191bmxvY2sodm9pZCkKIH0KIAogCi1zdGF0aWMg
Ym9vbCBtZW1jZ19zaG91bGRfZmx1c2hfc3RhdHMoc3RydWN0IG1lbV9jZ3JvdXAgKm1lbWNnKQor
c3RhdGljIGJvb2wgbWVtY2dfdm1zdGF0c19uZWVkc19mbHVzaChzdHJ1Y3QgbWVtY2dfdm1zdGF0
cyAqdm1zdGF0cykKIHsKLQlyZXR1cm4gYXRvbWljNjRfcmVhZCgmbWVtY2ctPnZtc3RhdHMtPnN0
YXRzX3VwZGF0ZXMpID4KKwlyZXR1cm4gYXRvbWljNjRfcmVhZCgmdm1zdGF0cy0+c3RhdHNfdXBk
YXRlcykgPgogCQlNRU1DR19DSEFSR0VfQkFUQ0ggKiBudW1fb25saW5lX2NwdXMoKTsKIH0KIAog
c3RhdGljIGlubGluZSB2b2lkIG1lbWNnX3JzdGF0X3VwZGF0ZWQoc3RydWN0IG1lbV9jZ3JvdXAg
Km1lbWNnLCBpbnQgdmFsKQogeworCXN0cnVjdCBtZW1jZ192bXN0YXRzX3BlcmNwdSAqc3RhdGM7
CiAJaW50IGNwdSA9IHNtcF9wcm9jZXNzb3JfaWQoKTsKLQl1bnNpZ25lZCBpbnQgeDsKIAogCWlm
ICghdmFsKQogCQlyZXR1cm47CiAKIAljZ3JvdXBfcnN0YXRfdXBkYXRlZChtZW1jZy0+Y3NzLmNn
cm91cCwgY3B1KTsKLQotCWZvciAoOyBtZW1jZzsgbWVtY2cgPSBwYXJlbnRfbWVtX2Nncm91cCht
ZW1jZykpIHsKLQkJeCA9IF9fdGhpc19jcHVfYWRkX3JldHVybihtZW1jZy0+dm1zdGF0c19wZXJj
cHUtPnN0YXRzX3VwZGF0ZXMsCi0JCQkJCSAgYWJzKHZhbCkpOwotCi0JCWlmICh4IDwgTUVNQ0df
Q0hBUkdFX0JBVENIKQorCXN0YXRjID0gdGhpc19jcHVfcHRyKG1lbWNnLT52bXN0YXRzX3BlcmNw
dSk7CisJZm9yICg7IHN0YXRjOyBzdGF0YyA9IHN0YXRjLT5wYXJlbnQpIHsKKwkJc3RhdGMtPnN0
YXRzX3VwZGF0ZXMgKz0gYWJzKHZhbCk7CisJCWlmIChzdGF0Yy0+c3RhdHNfdXBkYXRlcyA8IE1F
TUNHX0NIQVJHRV9CQVRDSCkKIAkJCWNvbnRpbnVlOwogCiAJCS8qCiAJCSAqIElmIEBtZW1jZyBp
cyBhbHJlYWR5IGZsdXNoLWFibGUsIGluY3JlYXNpbmcgc3RhdHNfdXBkYXRlcyBpcwogCQkgKiBy
ZWR1bmRhbnQuIEF2b2lkIHRoZSBvdmVyaGVhZCBvZiB0aGUgYXRvbWljIHVwZGF0ZS4KIAkJICov
Ci0JCWlmICghbWVtY2dfc2hvdWxkX2ZsdXNoX3N0YXRzKG1lbWNnKSkKLQkJCWF0b21pYzY0X2Fk
ZCh4LCAmbWVtY2ctPnZtc3RhdHMtPnN0YXRzX3VwZGF0ZXMpOwotCQlfX3RoaXNfY3B1X3dyaXRl
KG1lbWNnLT52bXN0YXRzX3BlcmNwdS0+c3RhdHNfdXBkYXRlcywgMCk7CisJCWlmICghbWVtY2df
dm1zdGF0c19uZWVkc19mbHVzaChzdGF0Yy0+dm1zdGF0cykpCisJCQlhdG9taWM2NF9hZGQoc3Rh
dGMtPnN0YXRzX3VwZGF0ZXMsCisJCQkJICAgICAmc3RhdGMtPnZtc3RhdHMtPnN0YXRzX3VwZGF0
ZXMpOworCQlzdGF0Yy0+c3RhdHNfdXBkYXRlcyA9IDA7CiAJfQogfQogCkBAIC03NTEsNyArNzU0
LDcgQEAgc3RhdGljIHZvaWQgZG9fZmx1c2hfc3RhdHModm9pZCkKIAogdm9pZCBtZW1fY2dyb3Vw
X2ZsdXNoX3N0YXRzKHZvaWQpCiB7Ci0JaWYgKG1lbWNnX3Nob3VsZF9mbHVzaF9zdGF0cyhyb290
X21lbV9jZ3JvdXApKQorCWlmIChtZW1jZ192bXN0YXRzX25lZWRzX2ZsdXNoKHJvb3RfbWVtX2Nn
cm91cC0+dm1zdGF0cykpCiAJCWRvX2ZsdXNoX3N0YXRzKCk7CiB9CiAKQEAgLTc2NSw3ICs3Njgs
NyBAQCB2b2lkIG1lbV9jZ3JvdXBfZmx1c2hfc3RhdHNfcmF0ZWxpbWl0ZWQodm9pZCkKIHN0YXRp
YyB2b2lkIGZsdXNoX21lbWNnX3N0YXRzX2R3b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqdykKIHsK
IAkvKgotCSAqIERlbGliZXJhdGVseSBpZ25vcmUgbWVtY2dfc2hvdWxkX2ZsdXNoX3N0YXRzKCkg
aGVyZSBzbyB0aGF0IGZsdXNoaW5nCisJICogRGVsaWJlcmF0ZWx5IGlnbm9yZSBtZW1jZ192bXN0
YXRzX25lZWRzX2ZsdXNoKCkgaGVyZSBzbyB0aGF0IGZsdXNoaW5nCiAJICogaW4gbGF0ZW5jeS1z
ZW5zaXRpdmUgcGF0aHMgaXMgYXMgY2hlYXAgYXMgcG9zc2libGUuCiAJICovCiAJZG9fZmx1c2hf
c3RhdHMoKTsKQEAgLTU0NTMsMTAgKzU0NTYsMTEgQEAgc3RhdGljIHZvaWQgbWVtX2Nncm91cF9m
cmVlKHN0cnVjdCBtZW1fY2dyb3VwICptZW1jZykKIAlfX21lbV9jZ3JvdXBfZnJlZShtZW1jZyk7
CiB9CiAKLXN0YXRpYyBzdHJ1Y3QgbWVtX2Nncm91cCAqbWVtX2Nncm91cF9hbGxvYyh2b2lkKQor
c3RhdGljIHN0cnVjdCBtZW1fY2dyb3VwICptZW1fY2dyb3VwX2FsbG9jKHN0cnVjdCBtZW1fY2dy
b3VwICpwYXJlbnQpCiB7CisJc3RydWN0IG1lbWNnX3Ztc3RhdHNfcGVyY3B1ICpzdGF0YywgKnBz
dGF0YzsKIAlzdHJ1Y3QgbWVtX2Nncm91cCAqbWVtY2c7Ci0JaW50IG5vZGU7CisJaW50IG5vZGUs
IGNwdTsKIAlpbnQgX19tYXliZV91bnVzZWQgaTsKIAlsb25nIGVycm9yID0gLUVOT01FTTsKIApA
QCAtNTQ4MCw2ICs1NDg0LDE0IEBAIHN0YXRpYyBzdHJ1Y3QgbWVtX2Nncm91cCAqbWVtX2Nncm91
cF9hbGxvYyh2b2lkKQogCWlmICghbWVtY2ctPnZtc3RhdHNfcGVyY3B1KQogCQlnb3RvIGZhaWw7
CiAKKwlmb3JfZWFjaF9wb3NzaWJsZV9jcHUoY3B1KSB7CisJCWlmIChwYXJlbnQpCisJCQlwc3Rh
dGMgPSBwZXJfY3B1X3B0cihwYXJlbnQtPnZtc3RhdHNfcGVyY3B1LCBjcHUpOworCQlzdGF0YyA9
IHBlcl9jcHVfcHRyKG1lbWNnLT52bXN0YXRzX3BlcmNwdSwgY3B1KTsKKwkJc3RhdGMtPnBhcmVu
dCA9IHBhcmVudCA/IHBzdGF0YyA6IE5VTEw7CisJCXN0YXRjLT52bXN0YXRzID0gbWVtY2ctPnZt
c3RhdHM7CisJfQorCiAJZm9yX2VhY2hfbm9kZShub2RlKQogCQlpZiAoYWxsb2NfbWVtX2Nncm91
cF9wZXJfbm9kZV9pbmZvKG1lbWNnLCBub2RlKSkKIAkJCWdvdG8gZmFpbDsKQEAgLTU1MjUsNyAr
NTUzNyw3IEBAIG1lbV9jZ3JvdXBfY3NzX2FsbG9jKHN0cnVjdCBjZ3JvdXBfc3Vic3lzX3N0YXRl
ICpwYXJlbnRfY3NzKQogCXN0cnVjdCBtZW1fY2dyb3VwICptZW1jZywgKm9sZF9tZW1jZzsKIAog
CW9sZF9tZW1jZyA9IHNldF9hY3RpdmVfbWVtY2cocGFyZW50KTsKLQltZW1jZyA9IG1lbV9jZ3Jv
dXBfYWxsb2MoKTsKKwltZW1jZyA9IG1lbV9jZ3JvdXBfYWxsb2MocGFyZW50KTsKIAlzZXRfYWN0
aXZlX21lbWNnKG9sZF9tZW1jZyk7CiAJaWYgKElTX0VSUihtZW1jZykpCiAJCXJldHVybiBFUlJf
Q0FTVChtZW1jZyk7Ci0tIAoyLjQzLjAuNDI5Lmc0MzJlYWEyYzZiLWdvb2cKCg==
--0000000000006ba232060f9817a0--

