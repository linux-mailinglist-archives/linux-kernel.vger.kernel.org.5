Return-Path: <linux-kernel+bounces-33969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A74A83710D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4B21C29318
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614965A106;
	Mon, 22 Jan 2024 18:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YOIBlZoH"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55FD5A108
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947573; cv=none; b=uXClg7Sv3Lk6k0J/5O3AvJDuUmYFcf+OIRwFHzCbjdw/uSjrO6T18c/X8ik48eVumsj5qW94blmsDu+nxGpNyS/sCfVoa06Uady4ee/KFdzF5ceVVEmQ6wWEpbwQ6O9doQAZjSso65r7vZyiH4eQs0DaYATqNBwvl3N/+dKKye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947573; c=relaxed/simple;
	bh=rxpWgB4jPslED0sKR78VNlQsesHWCSnhvhOvTd+JhSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udRFC/Jtyu+sxqndf1e/peOzo3wM1Lx4SV6hKZyzya+VctKwSGHh6FFIaNJRd4G7AmIpe8fHu4v71sFIwTPOT2rkYEsni2dEDR6wAU6thFukBpc8MQxSl21p6ayBomxLLgDP2w6rhES65Tbu5eegx6EOVW4jn22gyeqT3zUzY5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YOIBlZoH; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a308e6824ccso71753566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705947569; x=1706552369; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4Aw9HoHU0107I/z6RNXecJSxdvIQqi0/nb10ikcNBQ0=;
        b=YOIBlZoH+reu3Ko0PzbvpvL7HzcLxlQpu1Zg5Warq78o2SVIfH2Os7RwvJA9bd3dzl
         y+o2NrOr9m34ODrdwFrY0Ky1+0PVp3ZRYgWrNHV+DsL/cA/Rb38iWi/8qz6MN+TGJz9P
         jbnmqnbu479Ccu5S9RgrFiTNbg1X7pgSef56k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705947569; x=1706552369;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Aw9HoHU0107I/z6RNXecJSxdvIQqi0/nb10ikcNBQ0=;
        b=k1pOz4//wdd1KgQdmdSWV/n3ottr5AXQmM6NpmzXY4FlJDsbscqgsYjnMZoPA6KdJo
         ubewR+UilDEKLviJxsWoYdm9X5Qa5H154gsGVV2cAIEUA+tbVlFG2XG59RO1Bo5SnSqZ
         0MXCJ1l0M7KL9H20YdB+I+0omVDkylJNlmrc7mGHxkyiwMhuyrolP/pzvzg+y/Qp/Dhg
         g8T522qSTamaDKTqahHp7cZZE8+F9KLPA8Umb7u53jBZ80ijPnktXsSzr4tBYBTnWGtc
         DlVwD8LoESoHU+h32GjBmEz4bvoTcv08zDQs7GtLMtuapEzAQfFxaQYhJvKwnxOIupvM
         cEVw==
X-Gm-Message-State: AOJu0YyqrfRPeFiGiMSFYh1ZI6/JLtJPgO6vCrWRWcmBxLq7FdYRe9HE
	ilMagvl/sLzfJ2Pf8kkw8P51wvId/VCYDtoaZ1Aiur3+nrUyM6oIx9ZtmazDVnagc7wWQzpT4/L
	IdnMAlQ==
X-Google-Smtp-Source: AGHT+IFSGqKgZXD/9wo+1QsSpezC7d7Hiq8ehS6ti5SGLqkGjksn2D1keo+XP8yBaDLTPv3VHgRlmw==
X-Received: by 2002:a17:906:1b17:b0:a30:4618:80a0 with SMTP id o23-20020a1709061b1700b00a30461880a0mr1137652ejg.33.1705947569648;
        Mon, 22 Jan 2024 10:19:29 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id o26-20020a170906289a00b00a2bd8953af2sm13529422ejd.55.2024.01.22.10.19.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 10:19:28 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so3926921a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:19:28 -0800 (PST)
X-Received: by 2002:aa7:d8d6:0:b0:55a:9009:6827 with SMTP id
 k22-20020aa7d8d6000000b0055a90096827mr201655eds.11.1705947568241; Mon, 22 Jan
 2024 10:19:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117143548.595884070@goodmis.org> <20240117143810.531966508@goodmis.org>
 <CAMuHMdXKiorg-jiuKoZpfZyDJ3Ynrfb8=X+c7x0Eewxn-YRdCA@mail.gmail.com>
 <20240122100630.6a400dd3@gandalf.local.home> <CAMuHMdXD0weO4oku8g2du6fj-EzxGaF+0i=zrPScSXwphFAZgg@mail.gmail.com>
 <20240122114743.7e46b7cb@gandalf.local.home> <CAHk-=wiq5mr+wSb6pmtt7QqBhQo_xr7ip=yMwQ5ryWVwCyMhfg@mail.gmail.com>
 <CAHk-=wjGxVVKvxVf=NDnMhB3=eQ_NMiEY3onG1wRAjJepig=aw@mail.gmail.com>
In-Reply-To: <CAHk-=wjGxVVKvxVf=NDnMhB3=eQ_NMiEY3onG1wRAjJepig=aw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 22 Jan 2024 10:19:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiLqJYT2GGSBhKuJS-Uq1DVq3S32oP0SwqQiATuBivxcg@mail.gmail.com>
Message-ID: <CAHk-=wiLqJYT2GGSBhKuJS-Uq1DVq3S32oP0SwqQiATuBivxcg@mail.gmail.com>
Subject: Re: [for-linus][PATCH 1/3] eventfs: Have the inodes all for files and
 directories all be the same
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <keescook@chromium.org>, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Ajay Kaher <ajay.kaher@broadcom.com>
Content-Type: multipart/mixed; boundary="000000000000cfa3ae060f8cdedd"

--000000000000cfa3ae060f8cdedd
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 09:39, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Actually, why not juist add an inode number to your data structures,
> at least for directories? And just do a static increment on it as they
> get registered?
>
> That avoids the whole issue with possibly leaking kernel address data.

The 'nlink = 1' thing doesn't seem to make 'find' any happier for this
case, sadly.

But the inode number in the 'struct eventfs_inode' looks trivial. And
doesn't even grow that structure on 64-bit architectures at least,
because the struct is already 64-bit aligned, and had only one 32-bit
entry at the end.

On 32-bit architectures the structure size grows, but I'm not sure the
allocation size grows. Our kmalloc() is quantized at odd numbers.

IOW, this trivial patch seems to be much safer than worrying about
some pointer exposure.

              Linus

--000000000000cfa3ae060f8cdedd
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lrp92tln0>
X-Attachment-Id: f_lrp92tln0

IGZzL3RyYWNlZnMvZXZlbnRfaW5vZGUuYyB8IDYgKysrKy0tCiBmcy90cmFjZWZzL2ludGVybmFs
LmggICAgfCAxICsKIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2ZzL3RyYWNlZnMvZXZlbnRfaW5vZGUuYyBiL2ZzL3RyYWNlZnMv
ZXZlbnRfaW5vZGUuYwppbmRleCA2Nzk1ZmRhMmFmMTkuLjBiNTJlYzExMWNmMyAxMDA2NDQKLS0t
IGEvZnMvdHJhY2Vmcy9ldmVudF9pbm9kZS5jCisrKyBiL2ZzL3RyYWNlZnMvZXZlbnRfaW5vZGUu
YwpAQCAtMzk1LDggKzM5NSw3IEBAIHN0YXRpYyBzdHJ1Y3QgZGVudHJ5ICpjcmVhdGVfZGlyKHN0
cnVjdCBldmVudGZzX2lub2RlICplaSwgc3RydWN0IGRlbnRyeSAqcGFyZW50CiAJaW5vZGUtPmlf
b3AgPSAmZXZlbnRmc19yb290X2Rpcl9pbm9kZV9vcGVyYXRpb25zOwogCWlub2RlLT5pX2ZvcCA9
ICZldmVudGZzX2ZpbGVfb3BlcmF0aW9uczsKIAotCS8qIEFsbCBkaXJlY3RvcmllcyB3aWxsIGhh
dmUgdGhlIHNhbWUgaW5vZGUgbnVtYmVyICovCi0JaW5vZGUtPmlfaW5vID0gRVZFTlRGU19ESVJf
SU5PREVfSU5POworCWlub2RlLT5pX2lubyA9IGVpLT5pbm87CiAKIAl0aSA9IGdldF90cmFjZWZz
KGlub2RlKTsKIAl0aS0+ZmxhZ3MgfD0gVFJBQ0VGU19FVkVOVF9JTk9ERTsKQEAgLTg1OSw2ICs4
NTgsNyBAQCBzdHJ1Y3QgZXZlbnRmc19pbm9kZSAqZXZlbnRmc19jcmVhdGVfZGlyKGNvbnN0IGNo
YXIgKm5hbWUsIHN0cnVjdCBldmVudGZzX2lub2RlCiAJCQkJCSBpbnQgc2l6ZSwgdm9pZCAqZGF0
YSkKIHsKIAlzdHJ1Y3QgZXZlbnRmc19pbm9kZSAqZWk7CisJc3RhdGljIGludCBpbm9fY291bnRl
ciA9IEVWRU5URlNfRElSX0lOT0RFX0lOTzsKIAogCWlmICghcGFyZW50KQogCQlyZXR1cm4gRVJS
X1BUUigtRUlOVkFMKTsKQEAgLTg4OSw2ICs4ODksOCBAQCBzdHJ1Y3QgZXZlbnRmc19pbm9kZSAq
ZXZlbnRmc19jcmVhdGVfZGlyKGNvbnN0IGNoYXIgKm5hbWUsIHN0cnVjdCBldmVudGZzX2lub2Rl
CiAJSU5JVF9MSVNUX0hFQUQoJmVpLT5saXN0KTsKIAogCW11dGV4X2xvY2soJmV2ZW50ZnNfbXV0
ZXgpOworCWVpLT5pbm8gPSArK2lub19jb3VudGVyOworCiAJaWYgKCFwYXJlbnQtPmlzX2ZyZWVk
KSB7CiAJCWxpc3RfYWRkX3RhaWwoJmVpLT5saXN0LCAmcGFyZW50LT5jaGlsZHJlbik7CiAJCWVp
LT5kX3BhcmVudCA9IHBhcmVudC0+ZGVudHJ5OwpkaWZmIC0tZ2l0IGEvZnMvdHJhY2Vmcy9pbnRl
cm5hbC5oIGIvZnMvdHJhY2Vmcy9pbnRlcm5hbC5oCmluZGV4IDEyYjdkMDE1MGFlOS4uMWE1NzRk
MzA2ZWE5IDEwMDY0NAotLS0gYS9mcy90cmFjZWZzL2ludGVybmFsLmgKKysrIGIvZnMvdHJhY2Vm
cy9pbnRlcm5hbC5oCkBAIC02NCw2ICs2NCw3IEBAIHN0cnVjdCBldmVudGZzX2lub2RlIHsKIAkJ
c3RydWN0IGxsaXN0X25vZGUJbGxpc3Q7CiAJCXN0cnVjdCByY3VfaGVhZAkJcmN1OwogCX07CisJ
dW5zaWduZWQgaW50CQkJaW5vOwogCXVuc2lnbmVkIGludAkJCWlzX2ZyZWVkOjE7CiAJdW5zaWdu
ZWQgaW50CQkJaXNfZXZlbnRzOjE7CiAJdW5zaWduZWQgaW50CQkJbnJfZW50cmllczozMDsK
--000000000000cfa3ae060f8cdedd--

