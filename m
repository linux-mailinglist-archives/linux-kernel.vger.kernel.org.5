Return-Path: <linux-kernel+bounces-43580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480C58415E3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38F1281916
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8FF4F1FA;
	Mon, 29 Jan 2024 22:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DuebPeHD"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECD74F1F5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706568189; cv=none; b=RA0AUISt58hxI834OrcKlCg/bqnTrftode5q1qPcHk79DxqRDL4M2h01cJ144mTyvA05pItneWZqsL7R9pLxdqVuLkJU2SaUeISp0JFcMnSyx6wUTCvI1l+jLiR3P7/y8MOI850xmBYdwfCYKB9HLM20GWKb28Hnlx2urMYmWp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706568189; c=relaxed/simple;
	bh=p4fAypmGwh2MjrcCAAsFbLWW9Mlq0wjv4hcq1bO/MJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyVSvKhHtOmZ19658WM9ns1rfiV5zBbtEVdmE781kVC7VKchbxYT6wTzB8Lc98Q3FcbPQSjqB2Q6U3wpSufRIvE5fTXBPj+PU+wAE3jzrzS8W1jo6bwMc1456HWMBcLzyCP484RZDP9Cdg9nuhAENP0l7Bu8OB8v9nv+vLYuDIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DuebPeHD; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-510221ab3ebso4442145e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706568186; x=1707172986; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LygUeli+fkaFpTpY4T9pUkzxwshKh3bQFr+0h8Rxg7U=;
        b=DuebPeHD+iaOVxm5ilptsN7NqV3vA1vpRt0AsKzHjC3rA+/nITWZ+YUQ8E1rDuIuie
         TBERzriqOhOE+5atLv+0g/5TFRfHehlDTiIHDuXggvUYSIFUUxoThsF9X/XXHCcyMbGZ
         CIrUUwqtOaGUThL6TQszVU4FdX421ylGNCAvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706568186; x=1707172986;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LygUeli+fkaFpTpY4T9pUkzxwshKh3bQFr+0h8Rxg7U=;
        b=Lx67hkwjx18iyMVAJqfVE3Pf0wTkjYw6VW4mTUTeuwIAA1CVrvlmvJWPIGR3ygOmUo
         C82tbxXZJOD/tJvUPTv1264uAb/guEbXMWQJpd1VncDAifIINehjH1YRuDri46sJpuO+
         jeK7WeHU/WvAltu1NrvwoqJ5qAVePbRSf7ko7p+1ogseaNFCUZ6wcD+wCFQo03XGVQ3C
         jfSPv/3tottaRvwHGMtsN7u9lop4Y9WN+xU+oxUlqSqDwNMQ09bHR0bzZLlOxeDI6vvV
         CsH29REf5CPmT+t0P57jrtmePZhei04SJPIi6NNObhSyMJdDs0JoJXPJxbsgUaccKAAO
         Z3Aw==
X-Gm-Message-State: AOJu0YxcK6hzOpZdKzdxRfQ5SumqMdlevNK/6+2MwJbEK+XvIClsXS3d
	dhASMQNlDS1lbyMu4mPoJeP2StYU6WuSIOLpH0EyUNAVS4ooj1GLYP12m9CrXuHHnQL05vwHsMB
	KUr0=
X-Google-Smtp-Source: AGHT+IHgFmsstUwOoJ7Mg36RK1BsJ4jZfqFuD36ygBQb5lMooMy+JHpYK2Blx7JQRj0Nl2R1TH9y+g==
X-Received: by 2002:ac2:4d0d:0:b0:50e:730c:c410 with SMTP id r13-20020ac24d0d000000b0050e730cc410mr4564282lfi.46.1706568186122;
        Mon, 29 Jan 2024 14:43:06 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id d4-20020a193844000000b005110ad94472sm674194lfj.252.2024.01.29.14.43.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 14:43:04 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cf3a095ba6so38594731fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:43:04 -0800 (PST)
X-Received: by 2002:a2e:9958:0:b0:2cc:811f:f9ae with SMTP id
 r24-20020a2e9958000000b002cc811ff9aemr4489730ljj.47.1706568184184; Mon, 29
 Jan 2024 14:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com> <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
 <20240129120125.605e97af@gandalf.local.home> <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
 <CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
 <CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
 <20240129152600.7587d1aa@gandalf.local.home> <CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
 <20240129172200.1725f01b@gandalf.local.home> <CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
In-Reply-To: <CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jan 2024 14:42:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com>
Message-ID: <CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000683a4e06101d5e02"

--000000000000683a4e06101d5e02
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 14:35, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So just replace all the d_instantiate() calls there with "d_add()"
> instead. I think that will fix it.

I can confirm that with the mutex deadlock removed and the d_add()
fix, at least things *look* superficially ok.

I didn't actually do anything with it. So it might be leaking dentry
refs like mad or something like that, but at least the obvious cases
look fine.

just for completeness, here's the fixup diff I used.

                  Linus

--000000000000683a4e06101d5e02
Content-Type: text/x-patch; charset="US-ASCII"; name="fixup.diff"
Content-Disposition: attachment; filename="fixup.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lrzim0me0>
X-Attachment-Id: f_lrzim0me0

IGZzL3RyYWNlZnMvZXZlbnRfaW5vZGUuYyB8IDggKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvdHJhY2Vmcy9l
dmVudF9pbm9kZS5jIGIvZnMvdHJhY2Vmcy9ldmVudF9pbm9kZS5jCmluZGV4IGNkNmRlMzI0NDQ0
Mi4uNWIzMDdiYjY0ZjhmIDEwMDY0NAotLS0gYS9mcy90cmFjZWZzL2V2ZW50X2lub2RlLmMKKysr
IGIvZnMvdHJhY2Vmcy9ldmVudF9pbm9kZS5jCkBAIC0yMzAsNyArMjMwLDYgQEAgc3RhdGljIHN0
cnVjdCBldmVudGZzX2lub2RlICpldmVudGZzX2ZpbmRfZXZlbnRzKHN0cnVjdCBkZW50cnkgKmRl
bnRyeSkKIHsKIAlzdHJ1Y3QgZXZlbnRmc19pbm9kZSAqZWk7CiAKLQltdXRleF9sb2NrKCZldmVu
dGZzX211dGV4KTsKIAlkbyB7CiAJCS8vIFRoZSBwYXJlbnQgaXMgc3RhYmxlIGJlY2F1c2Ugd2Ug
ZG8gbm90IGRvIHJlbmFtZXMKIAkJZGVudHJ5ID0gZGVudHJ5LT5kX3BhcmVudDsKQEAgLTI0Nyw3
ICsyNDYsNiBAQCBzdGF0aWMgc3RydWN0IGV2ZW50ZnNfaW5vZGUgKmV2ZW50ZnNfZmluZF9ldmVu
dHMoc3RydWN0IGRlbnRyeSAqZGVudHJ5KQogCQl9CiAJCS8vIFdhbGsgdXB3YXJkcyB1bnRpbCB5
b3UgZmluZCB0aGUgZXZlbnRzIGlub2RlCiAJfSB3aGlsZSAoIWVpLT5pc19ldmVudHMpOwotCW11
dGV4X3VubG9jaygmZXZlbnRmc19tdXRleCk7CiAKIAl1cGRhdGVfdG9wX2V2ZW50c19hdHRyKGVp
LCBkZW50cnktPmRfc2IpOwogCkBAIC0zMjQsNyArMzIyLDcgQEAgc3RhdGljIHN0cnVjdCBkZW50
cnkgKmxvb2t1cF9maWxlKHN0cnVjdCBkZW50cnkgKmRlbnRyeSwKIAl0aS0+ZmxhZ3MgPSBUUkFD
RUZTX0VWRU5UX0lOT0RFOwogCXRpLT5wcml2YXRlID0gTlVMTDsJCQkvLyBEaXJlY3RvcmllcyBo
YXZlICdlaScsIGZpbGVzIG5vdAogCi0JZF9pbnN0YW50aWF0ZShkZW50cnksIGlub2RlKTsKKwlk
X2FkZChkZW50cnksIGlub2RlKTsKIAlmc25vdGlmeV9jcmVhdGUoZGVudHJ5LT5kX3BhcmVudC0+
ZF9pbm9kZSwgZGVudHJ5KTsKIAlyZXR1cm4gZXZlbnRmc19lbmRfY3JlYXRpbmcoZGVudHJ5KTsK
IH07CkBAIC0zNjUsNyArMzYzLDcgQEAgc3RhdGljIHN0cnVjdCBkZW50cnkgKmxvb2t1cF9kaXJf
ZW50cnkoc3RydWN0IGRlbnRyeSAqZGVudHJ5LAogICAgICAgICBlaS0+ZGVudHJ5ID0gZGVudHJ5
OwkvLyBSZW1vdmUgbWUhCiAKIAlpbmNfbmxpbmsoaW5vZGUpOwotCWRfaW5zdGFudGlhdGUoZGVu
dHJ5LCBpbm9kZSk7CisJZF9hZGQoZGVudHJ5LCBpbm9kZSk7CiAJaW5jX25saW5rKGRlbnRyeS0+
ZF9wYXJlbnQtPmRfaW5vZGUpOwogCWZzbm90aWZ5X21rZGlyKGRlbnRyeS0+ZF9wYXJlbnQtPmRf
aW5vZGUsIGRlbnRyeSk7CiAJcmV0dXJuIGV2ZW50ZnNfZW5kX2NyZWF0aW5nKGRlbnRyeSk7CkBA
IC03ODYsNyArNzg0LDcgQEAgc3RydWN0IGV2ZW50ZnNfaW5vZGUgKmV2ZW50ZnNfY3JlYXRlX2V2
ZW50c19kaXIoY29uc3QgY2hhciAqbmFtZSwgc3RydWN0IGRlbnRyeQogCiAJLyogZGlyZWN0b3J5
IGlub2RlcyBzdGFydCBvZmYgd2l0aCBpX25saW5rID09IDIgKGZvciAiLiIgZW50cnkpICovCiAJ
aW5jX25saW5rKGlub2RlKTsKLQlkX2luc3RhbnRpYXRlKGRlbnRyeSwgaW5vZGUpOworCWRfYWRk
KGRlbnRyeSwgaW5vZGUpOwogCWluY19ubGluayhkZW50cnktPmRfcGFyZW50LT5kX2lub2RlKTsK
IAlmc25vdGlmeV9ta2RpcihkZW50cnktPmRfcGFyZW50LT5kX2lub2RlLCBkZW50cnkpOwogCXRy
YWNlZnNfZW5kX2NyZWF0aW5nKGRlbnRyeSk7Cg==
--000000000000683a4e06101d5e02--

