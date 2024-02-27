Return-Path: <linux-kernel+bounces-84131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7594E86A299
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685051C23764
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E1E55776;
	Tue, 27 Feb 2024 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CpXjLBgf"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD6B1E86C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073315; cv=none; b=DBxx/P5Kjfa/973jIXdRrZPScaya85sXrcCijjB6sXzos9ZyLt16CZjkLXFUryD3JBd4lpK9TpkFRccxBW91xPN9DnadrPuTtEXm6Ef158xQhZeG6ALRt+pbsdhWpBcnE8rBORQPb2WdWoLAAcXn8shw7tBP7Iz333BJ4DC/rHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073315; c=relaxed/simple;
	bh=bU1XyaKXGe+O/mEyWnCgT6O04rrbmrD9+GXNZIedtCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5ks2lwNMS/omboHoJfF0cxnGhcsmTTBJQeL9wKXJ18Ts2AmREBNs6t2a25QFFLEVPW0uXU+c/vnxD706x5SfiZvct/aXFqGvYvVvdoGfcDkWR+tyFkTEXwEaUw0y/opZjIJvFaDB6hC7Gj3Jle49J60wAaiB0evQEE63OCFjTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CpXjLBgf; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so772051566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709073311; x=1709678111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=80tkN5Eohd449xb1/o8bHCFsCfXV3ux6KwUX2Tit340=;
        b=CpXjLBgfg3Q+5vek8hLkIQcosuVvPflUendIgyuIGBfMzgGrlU0L7NUsPHWrE6wHbp
         lI3k64YoKwmJf0c/M/sfEx7IzEB9kxxSwiH+Atlmnlm6oYBM3CnCB5AXUJouY1vT/f59
         6+gZB1sRw09AJpSbQSf2U5pkkqBJ8EfJzyKC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709073311; x=1709678111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80tkN5Eohd449xb1/o8bHCFsCfXV3ux6KwUX2Tit340=;
        b=HB918YLD7mAnGMlAzdZUcohtTXbMxOoDTjaoOMA7It1Qe1u8mV87odV6tpf8G1/eCF
         KGPEoLFK0F+biWhWmOSucHWkzgMXcX4eB0II9YT74tDtV7NRZX+pvx+0G07EME/EAcRw
         ZAHYtwfwW4A1qhIpksppjgP9UtW/5StaxQvNBVFIIB5uqu6bZ62VrLU9ESMbHt0TNDnd
         p0FvcJwXJnRJ5GWJ+ced9RyjgXK2aL9Xfr4gxtrBSgpn7EhoJs57VpBen8tspAtHnRtH
         ln9ePiaWx2NY4B0p2nn3tbSfr00CXErztVlYwYJC+Jo5BQkEMEtrOWRwqeaW+CrD2Pkq
         udLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWNEex0nIXw97fws+Vm4Absow/rV5iEuRLuMfpQ1GKY9gWzQsEW8blU/LCXI/xa1l+AzSvCr8m6i2el0tyKbq84Tn3IgXjkNVv+BiB
X-Gm-Message-State: AOJu0YxZpVWbia4zBGB29Xllali0tAm7sIqDicR70FM0obF0OFFrdpQe
	jrygf1n1OOjnXqUm4Zst33Tjh3fYV4/2/2J7kRnvbUJy5awmJoqd9r9jfax1DEfy7r/zCu/HRPk
	jZk+z0A==
X-Google-Smtp-Source: AGHT+IHb5IkLMSe7DEiyof0c6KqHeklXnoc1XiraXWjvGN0y/ievugJTEIQwQFGFdfC5HdmdvI85AQ==
X-Received: by 2002:a17:906:a00b:b0:a43:39fe:b475 with SMTP id p11-20020a170906a00b00b00a4339feb475mr4975931ejy.45.1709073311126;
        Tue, 27 Feb 2024 14:35:11 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id w9-20020a1709061f0900b00a3e4fc3919esm1184192ejj.31.2024.02.27.14.35.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 14:35:10 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a431324e84cso366331166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:35:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMTyzNUWYMKlhw8qzbot1uXU/YBpQK4TVObiSM14KufAHGRk7HkCl0xB7jh0lflRuxperkLrjJo8Feo50VIHmCuNJGuUKVvQotNlIo
X-Received: by 2002:a17:906:b118:b0:a3e:c3b0:e346 with SMTP id
 u24-20020a170906b11800b00a3ec3b0e346mr7243442ejy.16.1709073309594; Tue, 27
 Feb 2024 14:35:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170905252721.2268463.6714121678946763402.stgit@dwillia2-xfh.jf.intel.com>
 <170905254443.2268463.935306988251313983.stgit@dwillia2-xfh.jf.intel.com>
 <CAHk-=whBVhnh=KSeBBRet=E7qJAwnPR_aj5em187Q3FiD+LXnA@mail.gmail.com> <65de5725824ba_1138c72948c@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <65de5725824ba_1138c72948c@dwillia2-xfh.jf.intel.com.notmuch>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Feb 2024 14:34:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=whYxkfLVtBW_B-PgNqhKOAThTbfoH5CxtOTkwOB6VOt6w@mail.gmail.com>
Message-ID: <CAHk-=whYxkfLVtBW_B-PgNqhKOAThTbfoH5CxtOTkwOB6VOt6w@mail.gmail.com>
Subject: Re: [PATCH 3/3] cxl/region: Use cond_guard() in show_targetN()
To: Dan Williams <dan.j.williams@intel.com>
Cc: peterz@infradead.org, gregkh@linuxfoundation.org, 
	Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-cxl@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000083e343061264a3e1"

--00000000000083e343061264a3e1
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Feb 2024 at 13:42, Dan Williams <dan.j.williams@intel.com> wrote:
>
> I will also note that these last 3 statements, nuking the proposal from
> space, I find excessive. Yes, on the internet no one can hear you being
> subtle, but the "MORE READABLE" and "NOTHING" were pretty darn
> unequivocal, especially coming from the person who has absolute final
> say on what enters his project.

Heh. It's not just " one can hear you being subtle", sometimes it's
also "people don't take hints". It can be hard to tell..

Anyway, it's not that I hate the guard things in general. But I do
think they need to be used carefully, and I do think it's very
important that they have clean interfaces.

The current setup came about after quite long discussions about
getting reasonable syntax, and I'm still a bit worried even about the
current simpler ones.

And by "simpler ones" I don't mean our current scoped_cond_guard()
thing. We have exactly one user of it, and I have considered getting
rid of that one user because I think it's absolutely horrid. I haven't
figured out a better syntax for it.

For the non-scoped version, I actually think there *would* be a better
syntax - putting the error case after the macro (the way we put the
success case after the macro for the scoped one).

In fact, maybe the solution is to make the scoped and non-scoped
versions act very similar: we could do something like this:

        [scoped_]cond_guard(name, args) { success } else { fail };

and that syntax feels much more C-line to me.

So maybe something like the attached (TOTALLY UNTESTED!!) patch for
the scoped version, and then the non-scoped version would have the
same syntax (except it would have to generate that __UNIQUE_ID()
thing, of course).

I haven't thought much about this. But I think this would be more
acceptable to me, and also solve some of the ugliness with the current
pre-existing scoped_cond_guard().

I dunno. PeterZ did the existing stuff, but he's offlined due to
shoulder problems so not likely to chip in.

              Linus

--00000000000083e343061264a3e1
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lt4y3wa90>
X-Attachment-Id: f_lt4y3wa90

IGluY2x1ZGUvbGludXgvY2xlYW51cC5oIHwgNyArKystLS0tCiBrZXJuZWwvcHRyYWNlLmMgICAg
ICAgICB8IDUgKysrLS0KIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvY2xlYW51cC5oIGIvaW5jbHVkZS9s
aW51eC9jbGVhbnVwLmgKaW5kZXggYzJkMDliYzRmOTc2Li5hMDE1YWM5NTE3YTYgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvbGludXgvY2xlYW51cC5oCisrKyBiL2luY2x1ZGUvbGludXgvY2xlYW51cC5o
CkBAIC0xNDIsNyArMTQyLDcgQEAgc3RhdGljIGlubGluZSBjbGFzc18jI19uYW1lIyNfdCBjbGFz
c18jI19uYW1lIyNleHQjI19jb25zdHJ1Y3RvcihfaW5pdF9hcmdzKSBcCiAgKglmb3IgY29uZGl0
aW9uYWwgbG9ja3MgdGhlIGxvb3AgYm9keSBpcyBza2lwcGVkIHdoZW4gdGhlIGxvY2sgaXMgbm90
CiAgKglhY3F1aXJlZC4KICAqCi0gKiBzY29wZWRfY29uZF9ndWFyZCAobmFtZSwgZmFpbCwgYXJn
cy4uLikgeyB9OgorICogc2NvcGVkX2NvbmRfZ3VhcmQgKG5hbWUsIGFyZ3MuLi4pIHsgfSBbIGVs
c2UgeyBmYWlsIH0gOgogICogICAgICBzaW1pbGFyIHRvIHNjb3BlZF9ndWFyZCgpLCBleGNlcHQg
aXQgZG9lcyBmYWlsIHdoZW4gdGhlIGxvY2sKICAqICAgICAgYWNxdWlyZSBmYWlscy4KICAqCkBA
IC0xNjksMTEgKzE2OSwxMCBAQCBzdGF0aWMgaW5saW5lIGNsYXNzXyMjX25hbWUjI190IGNsYXNz
XyMjX25hbWUjI2V4dCMjX2NvbnN0cnVjdG9yKF9pbml0X2FyZ3MpIFwKIAlmb3IgKENMQVNTKF9u
YW1lLCBzY29wZSkoYXJncyksCQkJCQlcCiAJICAgICAqZG9uZSA9IE5VTEw7IF9fZ3VhcmRfcHRy
KF9uYW1lKSgmc2NvcGUpICYmICFkb25lOyBkb25lID0gKHZvaWQgKikxKQogCi0jZGVmaW5lIHNj
b3BlZF9jb25kX2d1YXJkKF9uYW1lLCBfZmFpbCwgYXJncy4uLikgXAorI2RlZmluZSBzY29wZWRf
Y29uZF9ndWFyZChfbmFtZSwgYXJncy4uLikgXAogCWZvciAoQ0xBU1MoX25hbWUsIHNjb3BlKShh
cmdzKSwgXAogCSAgICAgKmRvbmUgPSBOVUxMOyAhZG9uZTsgZG9uZSA9ICh2b2lkICopMSkgXAot
CQlpZiAoIV9fZ3VhcmRfcHRyKF9uYW1lKSgmc2NvcGUpKSBfZmFpbDsgXAotCQllbHNlCisJCWlm
IChfX2d1YXJkX3B0cihfbmFtZSkoJnNjb3BlKSkKIAogLyoKICAqIEFkZGl0aW9uYWwgaGVscGVy
IG1hY3JvcyBmb3IgZ2VuZXJhdGluZyBsb2NrIGd1YXJkcyB3aXRoIHR5cGVzLCBlaXRoZXIgZm9y
CmRpZmYgLS1naXQgYS9rZXJuZWwvcHRyYWNlLmMgYi9rZXJuZWwvcHRyYWNlLmMKaW5kZXggMmZh
YmQ0OTdkNjU5Li5mNTA5YjIxYTU3MTEgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9wdHJhY2UuYworKysg
Yi9rZXJuZWwvcHRyYWNlLmMKQEAgLTQ0MSw4ICs0NDEsNyBAQCBzdGF0aWMgaW50IHB0cmFjZV9h
dHRhY2goc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLCBsb25nIHJlcXVlc3QsCiAJICogU1VJRCwg
U0dJRCBhbmQgTFNNIGNyZWRzIGdldCBkZXRlcm1pbmVkIGRpZmZlcmVudGx5CiAJICogdW5kZXIg
cHRyYWNlLgogCSAqLwotCXNjb3BlZF9jb25kX2d1YXJkIChtdXRleF9pbnRyLCByZXR1cm4gLUVS
RVNUQVJUTk9JTlRSLAotCQkJICAgJnRhc2stPnNpZ25hbC0+Y3JlZF9ndWFyZF9tdXRleCkgewor
CXNjb3BlZF9jb25kX2d1YXJkIChtdXRleF9pbnRyLCAmdGFzay0+c2lnbmFsLT5jcmVkX2d1YXJk
X211dGV4KSB7CiAKIAkJc2NvcGVkX2d1YXJkICh0YXNrX2xvY2ssIHRhc2spIHsKIAkJCXJldHZh
bCA9IF9fcHRyYWNlX21heV9hY2Nlc3ModGFzaywgUFRSQUNFX01PREVfQVRUQUNIX1JFQUxDUkVE
Uyk7CkBAIC00NjYsNiArNDY1LDggQEAgc3RhdGljIGludCBwdHJhY2VfYXR0YWNoKHN0cnVjdCB0
YXNrX3N0cnVjdCAqdGFzaywgbG9uZyByZXF1ZXN0LAogCiAJCQlwdHJhY2Vfc2V0X3N0b3BwZWQo
dGFzayk7CiAJCX0KKwl9IGVsc2UgeworCQlyZXR1cm4gLUVSRVNUQVJUTk9JTlRSOwogCX0KIAog
CS8qCg==
--00000000000083e343061264a3e1--

