Return-Path: <linux-kernel+bounces-159052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 296488B28AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5921F2017A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5221514C0;
	Thu, 25 Apr 2024 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Iq9a5Joh"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8C314F116
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071694; cv=none; b=Dt9j5BEFTeMrdms3o4/DgqIQCNrxQg7zJ9AAOJDhvZ8dgKCbIHqlKPsqiyXHHUdYiGsQhClaKDxhkwgnBvixt0Ox4c3BRZ4J8I2xiOXJFfzPwNFkvTl/meM2XvJ0kO43E+GXN7bJONzzTamXmTZj1hPBgxq5hlJi9+HNO5lTBNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071694; c=relaxed/simple;
	bh=JeXz2/TFeNnXiSq/81VOk+f7TlrQg/8jpIhKlDJ3Qcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+2fXxGpNS810dUMbbg62jQbhiLSeVTaU6N1+w/0x0IxTpfIR1GxSZZgaXdktfrt48aD/90vr5yBNmIa7h7AbiPpJmNAzww1qJ90K8AHENjEe4Fuq0CmV7PqnzMdznCjjocgpCy2nzDhwx/z5o/QDpyqvDjAE853ISL51Y+z+dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Iq9a5Joh; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e477db7fbso1947249a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714071691; x=1714676491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S+CfDSUKDWMFi6696XWhw/F7Vcz9ViYAQl2uJokcaMA=;
        b=Iq9a5JohsTpZ1Plw8lZtgNq/zWMOnM/vDa6gZR988KJL3wzjPGq9S1AdIubOwOi8CH
         NPpmx9mtAibp77SJE81y/Z4W08avKFQ5qUZQ8IR2OfV8DUFBdPKD7igii1OzhoNYfDFr
         PzqrW1WJmyNn5Z5FOd5FWMytOdAVjucQnXWuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714071691; x=1714676491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S+CfDSUKDWMFi6696XWhw/F7Vcz9ViYAQl2uJokcaMA=;
        b=Quktd02UrDV6MrWfe3WqX1oLeKyLsg5HdBqlnFPtAV3wEJDc13DULjqrRXtSaePY6C
         LrNIU8srdGYRT8gT09sJYXAa6UIX/vFs5Tyv2OZjaApdhc3d/cROmVx3UdvnxMMR1CLQ
         6XsUway49VY0ARW3FsCNISCG5hexNw81+F1wxj5OKz1UZsIs2IeCUtiqMy03Uwn54XjO
         PN7EgOCDCG6o9kl/Wtr4IloFoOV8musDui7lCEhpbqnI2j+JsZAnSVczfluUCjyjwERu
         6eEoXSDnMMcE809NCoPaRYMFYfY/WDCU/2B3tuIeqacd2VH8fqxxXMoZeFhQI+A5UBjW
         /LrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiQXnGywyW5+BrxRDgkEM6DpTagfwBeKuCOnS96jal1MjkiB9kZix12MKkxp+2yStv/oI9RQvboJQcPkj4Ikgxr4oFe5ObqKbasmko
X-Gm-Message-State: AOJu0YzrNXUJSmc6UNb+z43WvK5iZkw+8o4eX/R5NnhJQobnY7yfT4xJ
	7EPZK/x3EkDSdAireE+uIT+XSGLFEtIHAQgnpa8D5LMv/0/qd2WdrC81+FRPItrV/MijP8O0gcH
	9MJtb3A==
X-Google-Smtp-Source: AGHT+IEpEOmzuU0uvdtl+1QWTeFNdgXPem9OIVUcQMproT8Vne7NEiQfFhiI6dHExnuAeMhhGUvjAQ==
X-Received: by 2002:a50:f68f:0:b0:571:be31:500b with SMTP id d15-20020a50f68f000000b00571be31500bmr406020edn.25.1714071691007;
        Thu, 25 Apr 2024 12:01:31 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id c26-20020aa7c99a000000b00572405680e8sm709026edt.21.2024.04.25.12.01.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 12:01:29 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a524ecaf215so174274266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:01:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvXwgWJ5uRnVevPYNi2VEgahKwFHpz8GeLhpeYAFI4i0VkW1QK/hTCUHjI+YWz5EfzSYa2I8vtKZvs+vzFCRvGaLAMq9+4RLE2saIw
X-Received: by 2002:a17:907:76a4:b0:a57:b828:5f4b with SMTP id
 jw4-20020a17090776a400b00a57b8285f4bmr452572ejc.58.1714071688536; Thu, 25 Apr
 2024 12:01:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0iUUmMUo86vBzYJjL4NjoFzpDwD1+c292aP+T++PLv6vQ@mail.gmail.com>
 <CAHk-=wj8J78-12QfAoKaLdRi2g1=_U7sv02POShjotcJ6t4nzw@mail.gmail.com>
In-Reply-To: <CAHk-=wj8J78-12QfAoKaLdRi2g1=_U7sv02POShjotcJ6t4nzw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Apr 2024 12:01:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgg2hknXUtxq8F7caSmbtRNpss0zhDwv505L25dfQBXDA@mail.gmail.com>
Message-ID: <CAHk-=wgg2hknXUtxq8F7caSmbtRNpss0zhDwv505L25dfQBXDA@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v6.9-rc6
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Apr 2024 at 11:58, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> When that macro now has had TWO independent bugs, how about you just
> write it out with explicit types and without any broken "helpers":
>
>    static inline u64 MASK_VAL(const struct cpc_reg *reg, u64 val)
>    {
>         u64 mask = (1ull << reg->bit_width)-1;
>         return (val >> reg->bit_offset) & mask;
>    }
>
> which is a few more lines, but doesn't that make it a whole lot more readable?
>
> And maybe this time, it's not a buggy mess?

Just to clarify: that was written in the MUA, and entirely untested.
Somebody should still verify it, but really, with already now two
bugs, that macro needs fixing for good, and the "for good" should be
looking at least _something_ like the above.

And despite needing fixing, I've done the pull, since bug #2 is at
least less bad than bug#1 was.

                   Linus

