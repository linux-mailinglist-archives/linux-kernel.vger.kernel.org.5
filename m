Return-Path: <linux-kernel+bounces-159644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 186918B3182
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A12DB24567
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E91713C3FD;
	Fri, 26 Apr 2024 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WciCIqmA"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FBF42040
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714117204; cv=none; b=E2uHQqDjSkS3Ip1J6LuQrW9VegbTe6yg40ZpdJWkbVj/6fGKZIej6C9e2XHOJ/emeQJGLOYT2G6wWVPKgNx6QoIYDHVdT05vtbKho6Ud/CLNYTndS8V1uDpln019wbhDzPYMfeG+JbCsxtkX8Ur63AL1HyFymBgEW2r1Z5PNYFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714117204; c=relaxed/simple;
	bh=kRZeq9J1Lob56Qgd0VoTrORXqmTf6VD/1OjkTqcezPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDgrpR/osVo3u9JXoR3alVfzmdWNEvitgxcUO2PE9wPAZVHOPsmdxED/LgOYDbwH26ChbiANAEGAUy0cHlXnWPx2VIhhqTs/3vk7f+M5xuvCws0qTozc2hrTk2KFHpPqAod0IKjeOa0knhakRdz+3G3kJmO4UyX+UBWctBIs/lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WciCIqmA; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-479c96509e1so650377137.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714117202; x=1714722002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jJkFy12YonlPcinlo/Ez/2n2sMJA9nVtlnRSuoAqn0=;
        b=WciCIqmAeYfU/a19E4GISaA+dX1Tk3PbaAsVw2HO1dMm6/Oyr/jHtAJUqeaeBFXAsa
         pjFRo0o8Qg7z2ba2KBEuRhFhVqP3jQdyUnpZTkW3H7IhqO8fRoCyBF86DX/vXLdYqcKt
         JivcPrUPLmp4E0X+7IgjYn2aJUMc/BuZo6qKQYU9QRNXNs7HftuSmkbiTQ+PATXF85Qu
         WCfUTjXACSbw0+zbi751O0r8SFZD3HzkqEgXRyKleqP+eR1GRggozYVO3H5htasWnQGN
         ISnqU11ehx3PQfpj5o6JvzFUBCe9rZJbeWjDy69uegETTnFt42WuQjgZl2iUW1D8XjlW
         FjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714117202; x=1714722002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jJkFy12YonlPcinlo/Ez/2n2sMJA9nVtlnRSuoAqn0=;
        b=HLNdiqBEXG4WsEuDIllcYTpkbx8avfjwIKqtzkWCdOmyo04M3WHl8E0E4wmaj0mwSF
         j10Vq5og2qvOR9a4LPnHTnZAn8lCERs0XuyTxBV6FkYqG67ucAkO2A7YLSqayuvARqkq
         Y3GmjyzByFKawkz+r66mx32ZH84HAJcUKTB9zwtVNB8rlBcVRiUiPPrF1q9V1yOyaY+B
         Nije7Ted+Zb+IcZLNVcpcPGTCDgZ/+56CTDYzi5KyzElL8K78ZqcRikQVFjryvDA3N6Z
         0cGpLNfBPBuB37dmzIlTIIuBYXYbaRoWjjnf2msxP3qZWS5mVC+RtS04eQKY0RBulE5q
         rbrw==
X-Forwarded-Encrypted: i=1; AJvYcCWfD8h5+LJYMGrrtGQj6ayjBjKBljxPFPYKqUwq92mL6etsGlJg9BNcc3gz03RI2KAI6n3QRnZG3s23AYZXBN4gWL+nuHDg8BV5Tz5u
X-Gm-Message-State: AOJu0YxkS8Ud7IW/Qhj3w7OICqSwjBNwjp2KoTzXG6U+3lnfnF1hErkT
	lT3oMI4oXLsXnMyqx+yQmLAqwD6nViTkDU1wYoe3EnyEkIq4gqSDQzN051NhaJplS93z8T903Lk
	iD8u/fskHdI5+nS7eKO+aDj26yf7dDtTGihkd
X-Google-Smtp-Source: AGHT+IFc8kJ8+D8jOCtw8nMrmAZ493g/im+/HWv9EcKWTwN6D9oveY+Oo0fCC424QZI4ufr7Pl/UQvzvgs3ciGwdXTs=
X-Received: by 2002:a05:6102:2222:b0:47b:c603:61af with SMTP id
 d2-20020a056102222200b0047bc60361afmr1859803vsb.14.1714117201862; Fri, 26 Apr
 2024 00:40:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708933498.git.isaku.yamahata@intel.com>
 <e324ff5e47e07505648c0092a5370ac9ddd72f0b.1708933498.git.isaku.yamahata@intel.com>
 <2daf03ae-6b5a-44ae-806e-76d09fb5273b@linux.intel.com> <20240313171428.GK935089@ls.amr.corp.intel.com>
 <52bc2c174c06f94a44e3b8b455c0830be9965cdf.camel@intel.com>
 <1d1da229d4bd56acabafd2087a5fabca9f48c6fc.camel@intel.com> <20240319215015.GA1994522@ls.amr.corp.intel.com>
In-Reply-To: <20240319215015.GA1994522@ls.amr.corp.intel.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 26 Apr 2024 08:39:26 +0100
Message-ID: <CA+EHjTxFZ3kzcMCeqgCv6+UsetAUUH4uSY_V02J1TqakM=HKKQ@mail.gmail.com>
Subject: Re: [PATCH v19 011/130] KVM: Add new members to struct kvm_gfn_range
 to operate on
To: Isaku Yamahata <isaku.yamahata@intel.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Zhang, Tina" <tina.zhang@intel.com>, 
	"isaku.yamahata@linux.intel.com" <isaku.yamahata@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>, 
	"Huang, Kai" <kai.huang@intel.com>, "sagis@google.com" <sagis@google.com>, "Chen, Bo2" <chen.bo@intel.com>, 
	"isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"Yuan, Hang" <hang.yuan@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 9:50=E2=80=AFPM Isaku Yamahata <isaku.yamahata@inte=
l.com> wrote:
>
> On Tue, Mar 19, 2024 at 02:47:47PM +0000,
> "Edgecombe, Rick P" <rick.p.edgecombe@intel.com> wrote:
>
> > On Mon, 2024-03-18 at 19:50 -0700, Rick Edgecombe wrote:
> > > On Wed, 2024-03-13 at 10:14 -0700, Isaku Yamahata wrote:
> > > > > IMO, an enum will be clearer than the two flags.
> > > > >
> > > > >     enum {
> > > > >         PROCESS_PRIVATE_AND_SHARED,
> > > > >         PROCESS_ONLY_PRIVATE,
> > > > >         PROCESS_ONLY_SHARED,
> > > > >     };
> > > >
> > > > The code will be ugly like
> > > > "if (=3D=3D PRIVATE || =3D=3D PRIVATE_AND_SHARED)" or
> > > > "if (=3D=3D SHARED || =3D=3D PRIVATE_AND_SHARED)"
> > > >
> > > > two boolean (or two flags) is less error-prone.
> > >
> > > Yes the enum would be awkward to handle. But I also thought the way
> > > this is specified in struct kvm_gfn_range is a little strange.
> > >
> > > It is ambiguous what it should mean if you set:
> > >  .only_private=3Dtrue;
> > >  .only_shared=3Dtrue;
> > > ...as happens later in the series (although it may be a mistake).
> > >
> > > Reading the original conversation, it seems Sean suggested this
> > > specifically. But it wasn't clear to me from the discussion what the
> > > intention of the "only" semantics was. Like why not?
> > >  bool private;
> > >  bool shared;
> >
> > I see Binbin brought up this point on v18 as well:
> > https://lore.kernel.org/kvm/6220164a-aa1d-43d2-b918-6a6eaad769fb@linux.=
intel.com/#t
> >
> > and helpfully dug up some other discussion with Sean where he agreed
> > the "_only" is confusing and proposed the the enum:
> > https://lore.kernel.org/kvm/ZUO1Giju0GkUdF0o@google.com/
> >
> > He wanted the default value (in the case the caller forgets to set
> > them), to be to include both private and shared. I think the enum has
> > the issues that Isaku mentioned. What about?
> >
> >  bool exclude_private;
> >  bool exclude_shared;
> >
> > It will become onerous if more types of aliases grow, but it clearer
> > semantically and has the safe default behavior.
>
> I'm fine with those names. Anyway, I'm fine with wither way, two bools or=
 enum.

I don't have a strong opinion, but I'd brought it up in a previous
patch series. I think that having two bools to encode three states is
less intuitive and potentially more bug prone, more so than the naming
itself (i.e., _only):
https://lore.kernel.org/all/ZUO1Giju0GkUdF0o@google.com/

Cheers,
/fuad

> --
> Isaku Yamahata <isaku.yamahata@intel.com>
>

