Return-Path: <linux-kernel+bounces-45016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83805842A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375DC28560C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6901292D7;
	Tue, 30 Jan 2024 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LTWDmWD1"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55164823CC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634566; cv=none; b=qO6jHMcH7do4wvC0NGxVBAg1N1XNknGmIW1LXFsBBJTxM7A/1BLtAstQXBwIcI9tt3CS/bm6/9mCV+WVFugxwo9RyHbjKYIf5MeUQ9WPt0nnLSXFLHohy9+NF/UfqrA5uT8j2LAtt/qNXKL+iJlNXhVbz6MtlGNqcWWSk7nYGQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634566; c=relaxed/simple;
	bh=OQn8hC4ZkfJdMMsbefth4JV/39ONC8FzGYAJXp/p1bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcxJB9t1D3A7afiatvqJQ58rK40lGF8S6Vif1tkDB0zmNosoWiMPsR5Rt1TsRJNHotts5jElX0eh9aeoBt1FJqixS9w+F/Br0HWKMzQROW3vZWTAd79tM7n+krbHZu18bCRS2s+GK9dqKAuenrBFj5dnNroHZpz+QC/axg4AqGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LTWDmWD1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so3598224a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706634562; x=1707239362; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Djs1OTbFMC+4TjUzpye92JIfwg7EBRT3Q8+brNbcyPk=;
        b=LTWDmWD1ajWTsa3l3QtzO3dMZbgewMLcp6A+ere3Wp93BIQ0MtYkYUP6BlfBC6mkx8
         S+gJvkj2AvQGIBBxIMfHh561dHSVdoL44nWks4bIe2BndDbMjvuTng7N4tFa3kN4BZoT
         ugWitAUNs+FQueRRQhoz/0TST4R8Wm4/fH7js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706634562; x=1707239362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Djs1OTbFMC+4TjUzpye92JIfwg7EBRT3Q8+brNbcyPk=;
        b=L8mrf+jnelqVYK2CljgLy76lghFmB8qnQeB0ETsH8AL/9wv03S/asROhVdPtoslxQo
         KPVNYl/Hv6GXlLNi0IK8scBy+DayGieeSNnsC0Rudi9xEoWi4Vm+TsMWX1KsZ4xb+s9K
         XddPPq9ewDyDxOuVlOv2819rSJN7A4P2pj9/umOZt+gYuwseESO7fUb04PdhRaNNpUl1
         A9HoYzoXIM6E6660MYPpPf4MIZwLfwqaYA9HD3mjr21S9uvjWNMmcbypeunxxkNgGCLe
         uyzZZIDVdEH+rXoH08mvDMIbBUYvzYCxUElTEYoYI+T4lB5crt7ZE/XEtcIoFcs6412+
         ku1A==
X-Gm-Message-State: AOJu0Yy1F4QI5b4gryaFTWETg+BsdV/r90CNeuYAoi7915A/cjmwOdjl
	yolOtvL9RjouDYJuhbOoyBW+DgXF6VpMYOITaOXvze7vWDydm8zm8nQv7J+0HLnIBdB/0rb4hCR
	WI+zoGw==
X-Google-Smtp-Source: AGHT+IFWQfkoDw3QW99KSlIwJ13blmM8GII8hpfVPc4P+u9LxOS+tHTyruARsUz9cDxK8EslqZsUqg==
X-Received: by 2002:a17:906:d7b1:b0:a35:c371:8b27 with SMTP id pk17-20020a170906d7b100b00a35c3718b27mr4147965ejb.30.1706634562257;
        Tue, 30 Jan 2024 09:09:22 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id qt11-20020a170906eceb00b00a358f659989sm3059462ejb.113.2024.01.30.09.09.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 09:09:20 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so3598141a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:09:20 -0800 (PST)
X-Received: by 2002:a05:6402:2692:b0:55c:7aa7:53a9 with SMTP id
 w18-20020a056402269200b0055c7aa753a9mr7521104edd.5.1706634559950; Tue, 30 Jan
 2024 09:09:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com> <CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
 <CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
 <20240129152600.7587d1aa@gandalf.local.home> <CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
 <20240129172200.1725f01b@gandalf.local.home> <CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
 <CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com>
 <20240129174950.5a17a86c@gandalf.local.home> <CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
 <20240129193549.265f32c8@gandalf.local.home> <CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
 <CAHk-=wh97AkwaOkXoBgf0z8EP88ePffLnTcmmQXcY+AhFaFrnA@mail.gmail.com>
 <CAHk-=wi6m7d-nivx10Lo=aGhbdk2qg-8SzjtDd9XW01LxGgAMA@mail.gmail.com>
 <CAHk-=wi+WbXZcc2Sx1i-MGV2DfG4eS4Ci+mrqi-PBSLSnww6qA@mail.gmail.com>
 <20240130093942.56206ff1@gandalf.local.home> <20240130114947.5bc856b0@gandalf.local.home>
 <CAHk-=wiNY3W1QKveFnH=dJtRNW7kA1Nbn6Ua49EbM6AC+Rx8wg@mail.gmail.com>
In-Reply-To: <CAHk-=wiNY3W1QKveFnH=dJtRNW7kA1Nbn6Ua49EbM6AC+Rx8wg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 09:09:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjb=Kc_i+qwA-Rp07Qp015sBkcox9y2V-MS+Rx=FthuEA@mail.gmail.com>
Message-ID: <CAHk-=wjb=Kc_i+qwA-Rp07Qp015sBkcox9y2V-MS+Rx=FthuEA@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b536a306102cd2ec"

--000000000000b536a306102cd2ec
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 08:55, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Let me just reboot into it to test that I got all the cases.
>
> It makes the code even more obvious, and avoids all the complexity.

Yup, this works at least for the case you pointed out, and it really
feels like the RightThing(tm) from a VFS standpoint.

NOTE! This patch is on top of my previous 5-patch series.

                 Linus

--000000000000b536a306102cd2ec
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-eventfs-clean-up-dentry-ops-and-add-revalidate-funct.patch"
Content-Disposition: attachment; 
	filename="0001-eventfs-clean-up-dentry-ops-and-add-revalidate-funct.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ls0m4fg60>
X-Attachment-Id: f_ls0m4fg60

RnJvbSA2N2IzMWJiNTNlZjY1MTMyYTY1YmZiZTkxNTYyOGM0ODFhMzllNzNhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFR1ZSwgMzAgSmFuIDIwMjQgMDk6MDA6MTggLTA4MDAKU3ViamVjdDog
W1BBVENIXSBldmVudGZzOiBjbGVhbiB1cCBkZW50cnkgb3BzIGFuZCBhZGQgcmV2YWxpZGF0ZSBm
dW5jdGlvbgoKSW4gb3JkZXIgZm9yIHRoZSBkZW50cmllcyB0byBzdGF5IHVwLXRvLWRhdGUgd2l0
aCB0aGUgZXZlbnRmcyBjaGFuZ2VzLApqdXN0IGFkZCBhICdkX3JldmFsaWRhdGUnIGZ1bmN0aW9u
IHRoYXQgY2hlY2tzIHRoZSAnaXNfZnJlZWQnIGJpdC4KCkFsc28sIGNsZWFuIHVwIHRoZSBkZW50
cnkgcmVsZWFzZSB0byBhY3R1YWxseSB1c2UgZF9yZWxlYXNlKCkgcmF0aGVyCnRoYW4gdGhlIHNs
aWdodGx5IG9kZCBkX2lwdXQoKSBmdW5jdGlvbi4gIFdlIGRvbid0IGNhcmUgYWJvdXQgdGhlIGlu
b2RlLAphbGwgd2Ugd2FudCB0byBkbyBpcyB0byBnZXQgcmlkIG9mIHRoZSByZWZjb3VudCB0byB0
aGUgZXZlbnRmcyBkYXRhCmFkZGVkIGJ5IGRlbnRyeS0+ZF9mc2RhdGEuCgpJdCB3b3VsZCBwcm9i
YWJseSBiZSBjbGVhbmVyIHRvIG1ha2UgZXZlbnRmcyBpdHMgb3duIGZpbGVzeXN0ZW0sIG9yIGF0
CmxlYXN0IHNldCBpdHMgb3duIGRlbnRyeSBvcHMgd2hlbiBsb29raW5nIHVwIGV2ZW50ZnMgZmls
ZXMuICBCdXQgYXMgaXQKaXMsIG9ubHkgZXZlbnRmcyBkZW50cmllcyB1c2UgZF9mc2RhdGEsIHNv
IHdlIGRvbid0IHJlYWxseSBuZWVkIHRvIHNwbGl0CnRoZXNlIHRoaW5ncyB1cCBieSB1c2UuCgpB
bm90aGVyIHRoaW5nIHRoYXQgbWlnaHQgYmUgd29ydGggZG9pbmcgaXMgdG8gbWFrZSBhbGwgZXZl
bnRmcyBsb29rdXBzCm1hcmsgdGhlaXIgZGVudHJpZXMgYXMgbm90IHdvcnRoIGNhY2hpbmcuICBX
ZSBjb3VsZCBkbyB0aGF0IHdpdGgKZF9kZWxldGUoKSwgYnV0IHRoZSBEQ0FDSEVfRE9OVENBQ0hF
IGZsYWcgd291bGQgbGlrZWx5IGJlIGV2ZW4gYmV0dGVyLgoKQXMgaXQgaXMsIHRoZSBkZW50cmll
cyBhcmUgYWxsIGZyZWVhYmxlLCBidXQgdGhleSBvbmx5IHRlbmQgdG8gZ2V0IGZyZWVkCmF0IG1l
bW9yeSBwcmVzc3VyZSByYXRoZXIgdGhhbiBtb3JlIHByb2FjdGl2ZWx5LiAgQnV0IHRoYXQncyBh
IHNlcGFyYXRlCmlzc3VlLgoKU2lnbmVkLW9mZi1ieTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRz
QGxpbnV4LWZvdW5kYXRpb24ub3JnPgotLS0KIGZzL3RyYWNlZnMvZXZlbnRfaW5vZGUuYyB8IDIx
ICsrKysrLS0tLS0tLS0tLS0tLS0tLQogZnMvdHJhY2Vmcy9pbm9kZS5jICAgICAgIHwgMjcgKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tCiBmcy90cmFjZWZzL2ludGVybmFsLmggICAgfCAgMyAr
Ky0KIDMgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZnMvdHJhY2Vmcy9ldmVudF9pbm9kZS5jIGIvZnMvdHJhY2Vmcy9ldmVudF9p
bm9kZS5jCmluZGV4IGEzN2RiMGRhYzMwMi4uYWNkYzc5N2JkOWMwIDEwMDY0NAotLS0gYS9mcy90
cmFjZWZzL2V2ZW50X2lub2RlLmMKKysrIGIvZnMvdHJhY2Vmcy9ldmVudF9pbm9kZS5jCkBAIC00
MTQsMjMgKzQxNCwxNCBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBldmVudGZzX2lub2RlICphbGxv
Y19laShjb25zdCBjaGFyICpuYW1lKQogCiAKIC8qKgotICogZXZlbnRmc19zZXRfZWlfc3RhdHVz
X2ZyZWUgLSByZW1vdmUgdGhlIGRlbnRyeSByZWZlcmVuY2UgZnJvbSBhbiBldmVudGZzX2lub2Rl
Ci0gKiBAdGk6IHRoZSB0cmFjZWZzX2lub2RlIG9mIHRoZSBkZW50cnkKKyAqIGV2ZW50ZnNfZF9y
ZWxlYXNlIC0gZGVudHJ5IGlzIGdvaW5nIGF3YXkKICAqIEBkZW50cnk6IGRlbnRyeSB3aGljaCBo
YXMgdGhlIHJlZmVyZW5jZSB0byByZW1vdmUuCiAgKgogICogUmVtb3ZlIHRoZSBhc3NvY2lhdGlv
biBiZXR3ZWVuIGEgZGVudHJ5IGZyb20gYW4gZXZlbnRmc19pbm9kZS4KICAqLwotdm9pZCBldmVu
dGZzX3NldF9laV9zdGF0dXNfZnJlZShzdHJ1Y3QgdHJhY2Vmc19pbm9kZSAqdGksIHN0cnVjdCBk
ZW50cnkgKmRlbnRyeSkKK3ZvaWQgZXZlbnRmc19kX3JlbGVhc2Uoc3RydWN0IGRlbnRyeSAqZGVu
dHJ5KQogewotCXN0cnVjdCBldmVudGZzX2lub2RlICplaTsKLQotCW11dGV4X2xvY2soJmV2ZW50
ZnNfbXV0ZXgpOwotCWVpID0gZGVudHJ5LT5kX2ZzZGF0YTsKLQlpZiAoZWkpIHsKLQkJZGVudHJ5
LT5kX2ZzZGF0YSA9IE5VTEw7Ci0JCXB1dF9laShlaSk7Ci0JfQotCW11dGV4X3VubG9jaygmZXZl
bnRmc19tdXRleCk7CisJcHV0X2VpKGRlbnRyeS0+ZF9mc2RhdGEpOwogfQogCiAvKioKQEAgLTUx
Nyw5ICs1MDgsOCBAQCBzdGF0aWMgc3RydWN0IGRlbnRyeSAqZXZlbnRmc19yb290X2xvb2t1cChz
dHJ1Y3QgaW5vZGUgKmRpciwKIAl9CiAKICBlbm9lbnQ6Ci0JLyogTm90aGluZyBmb3VuZD8gKi8K
LQlkX2FkZChkZW50cnksIE5VTEwpOwotCXJlc3VsdCA9IE5VTEw7CisJLyogRG9uJ3QgY2FjaGUg
bmVnYXRpdmUgbG9va3VwcywganVzdCByZXR1cm4gYW4gZXJyb3IgKi8KKwlyZXN1bHQgPSBFUlJf
UFRSKC1FTk9FTlQpOwogCiAgb3V0OgogCW11dGV4X3VubG9jaygmZXZlbnRmc19tdXRleCk7CkBA
IC04NTcsNiArODQ3LDUgQEAgdm9pZCBldmVudGZzX3JlbW92ZV9ldmVudHNfZGlyKHN0cnVjdCBl
dmVudGZzX2lub2RlICplaSkKIAkgKiBzdGlja3MgYXJvdW5kIHdoaWxlIHRoZSBvdGhlciBlaS0+
ZGVudHJ5IGFyZSBjcmVhdGVkCiAJICogYW5kIGRlc3Ryb3llZCBkeW5hbWljYWxseS4KIAkgKi8K
LQlzaW1wbGVfcmVjdXJzaXZlX3JlbW92YWwoZGVudHJ5LCBOVUxMKTsKIAlkcHV0KGRlbnRyeSk7
CiB9CmRpZmYgLS1naXQgYS9mcy90cmFjZWZzL2lub2RlLmMgYi9mcy90cmFjZWZzL2lub2RlLmMK
aW5kZXggZTFiMTcyYzBlMDkxLi42NDEyMjc4N2U1ZDAgMTAwNjQ0Ci0tLSBhL2ZzL3RyYWNlZnMv
aW5vZGUuYworKysgYi9mcy90cmFjZWZzL2lub2RlLmMKQEAgLTM3OSwyMSArMzc5LDMwIEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgc3VwZXJfb3BlcmF0aW9ucyB0cmFjZWZzX3N1cGVyX29wZXJhdGlv
bnMgPSB7CiAJLnNob3dfb3B0aW9ucwk9IHRyYWNlZnNfc2hvd19vcHRpb25zLAogfTsKIAotc3Rh
dGljIHZvaWQgdHJhY2Vmc19kZW50cnlfaXB1dChzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIHN0cnVj
dCBpbm9kZSAqaW5vZGUpCisvKgorICogSXQgd291bGQgYmUgY2xlYW5lciBpZiBldmVudGZzIGhh
ZCBpdHMgb3duIGRlbnRyeSBvcHMuCisgKgorICogTm90ZSB0aGF0IGRfcmV2YWxpZGF0ZSBpcyBj
YWxsZWQgcG90ZW50aWFsbHkgdW5kZXIgUkNVLAorICogc28gaXQgY2FuJ3QgdGFrZSB0aGUgZXZl
bnRmcyBtdXRleCBldGMuIEl0J3MgZmluZSAtIGlmCisgKiB3ZSBvcGVuIGEgZmlsZSBqdXN0IGFz
IGl0J3MgbWFya2VkIGRlYWQsIHRoaW5ncyB3aWxsCisgKiBzdGlsbCB3b3JrIGp1c3QgZmluZSwg
YW5kIGp1c3Qgc2VlIHRoZSBvbGQgc3RhbGUgY2FzZS4KKyAqLworc3RhdGljIHZvaWQgdHJhY2Vm
c19kX3JlbGVhc2Uoc3RydWN0IGRlbnRyeSAqZGVudHJ5KQogewotCXN0cnVjdCB0cmFjZWZzX2lu
b2RlICp0aTsKKwlpZiAoZGVudHJ5LT5kX2ZzZGF0YSkKKwkJZXZlbnRmc19kX3JlbGVhc2UoZGVu
dHJ5KTsKK30KIAotCWlmICghZGVudHJ5IHx8ICFpbm9kZSkKLQkJcmV0dXJuOworc3RhdGljIGlu
dCB0cmFjZWZzX2RfcmV2YWxpZGF0ZShzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIHVuc2lnbmVkIGlu
dCBmbGFncykKK3sKKwlzdHJ1Y3QgZXZlbnRmc19pbm9kZSAqZWkgPSBkZW50cnktPmRfZnNkYXRh
OwogCi0JdGkgPSBnZXRfdHJhY2Vmcyhpbm9kZSk7Ci0JaWYgKHRpICYmIHRpLT5mbGFncyAmIFRS
QUNFRlNfRVZFTlRfSU5PREUpCi0JCWV2ZW50ZnNfc2V0X2VpX3N0YXR1c19mcmVlKHRpLCBkZW50
cnkpOwotCWlwdXQoaW5vZGUpOworCXJldHVybiAhKGVpICYmIGVpLT5pc19mcmVlZCk7CiB9CiAK
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGVudHJ5X29wZXJhdGlvbnMgdHJhY2Vmc19kZW50cnlfb3Bl
cmF0aW9ucyA9IHsKLQkuZF9pcHV0ID0gdHJhY2Vmc19kZW50cnlfaXB1dCwKKwkuZF9yZXZhbGlk
YXRlID0gdHJhY2Vmc19kX3JldmFsaWRhdGUsCisJLmRfcmVsZWFzZSA9IHRyYWNlZnNfZF9yZWxl
YXNlLAogfTsKIAogc3RhdGljIGludCB0cmFjZV9maWxsX3N1cGVyKHN0cnVjdCBzdXBlcl9ibG9j
ayAqc2IsIHZvaWQgKmRhdGEsIGludCBzaWxlbnQpCmRpZmYgLS1naXQgYS9mcy90cmFjZWZzL2lu
dGVybmFsLmggYi9mcy90cmFjZWZzL2ludGVybmFsLmgKaW5kZXggNzJkYjNiZGM0ZGZiLi5kNDE5
NDQ2NmI2NDMgMTAwNjQ0Ci0tLSBhL2ZzL3RyYWNlZnMvaW50ZXJuYWwuaAorKysgYi9mcy90cmFj
ZWZzL2ludGVybmFsLmgKQEAgLTc5LDYgKzc5LDcgQEAgc3RydWN0IGlub2RlICp0cmFjZWZzX2dl
dF9pbm9kZShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKTsKIHN0cnVjdCBkZW50cnkgKmV2ZW50ZnNf
c3RhcnRfY3JlYXRpbmcoY29uc3QgY2hhciAqbmFtZSwgc3RydWN0IGRlbnRyeSAqcGFyZW50KTsK
IHN0cnVjdCBkZW50cnkgKmV2ZW50ZnNfZmFpbGVkX2NyZWF0aW5nKHN0cnVjdCBkZW50cnkgKmRl
bnRyeSk7CiBzdHJ1Y3QgZGVudHJ5ICpldmVudGZzX2VuZF9jcmVhdGluZyhzdHJ1Y3QgZGVudHJ5
ICpkZW50cnkpOwotdm9pZCBldmVudGZzX3NldF9laV9zdGF0dXNfZnJlZShzdHJ1Y3QgdHJhY2Vm
c19pbm9kZSAqdGksIHN0cnVjdCBkZW50cnkgKmRlbnRyeSk7CisKK3ZvaWQgZXZlbnRmc19kX3Jl
bGVhc2Uoc3RydWN0IGRlbnRyeSAqZGVudHJ5KTsKIAogI2VuZGlmIC8qIF9UUkFDRUZTX0lOVEVS
TkFMX0ggKi8KLS0gCjIuNDMuMC41LmczOGZiMTM3YmRiCgo=
--000000000000b536a306102cd2ec--

