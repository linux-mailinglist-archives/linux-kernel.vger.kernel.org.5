Return-Path: <linux-kernel+bounces-153523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC8C8ACF1D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A322823D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E961509AF;
	Mon, 22 Apr 2024 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkZT/ouS"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F721509A9;
	Mon, 22 Apr 2024 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795345; cv=none; b=LHaqwBUML1I/urwLaYVQwq6oq3sBn+dVIPWEXy7cVgziSURN3+HyIOWoqYnYlhmxYzTAKyeHclpgtEhjDIBbWg/16uVcSdzeXvwb4u94LOBq4EGETNF9+RJDR6XXVVEzC7XmcDmPvysDjLMuRkkHUtvPn3WuaRVqcM7/7/6Ivr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795345; c=relaxed/simple;
	bh=hEvNS87p39Z1frzI0wCQ9B0ZqbVWadl24hmpRMpTSYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKRLcqwS8oCeEJ+1n944hdvEVV80yOCq6ojYg+JwlRv5gBWcOfoNcS8R1QDymn78qE9bgX5qvQgAkNrhrgrRjvCR7C+lq0Ua++mCw/JBa7oQpoOeEZKBEki1XfWXer1TmbRwezM4pJzPnm1O2EtaWPNWSC+586JX8wKFtbiMq1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkZT/ouS; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d8a24f8a3cso55875511fa.1;
        Mon, 22 Apr 2024 07:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713795341; x=1714400141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCVaFWgYPulgT/NxtvZ6t6tkYKya9dvfI35PAROfzCM=;
        b=FkZT/ouSsch4YhaxwSAkOTptoo8K6jTIQfv8sz/+MFwNvG9MeMnVv413ggH8YTaGa9
         mYlCWbn9NMNhqCrhH/Zao1A14RMlabYh31l/gx+Fpwx48H82dXlmgf6iIzyTuVR2wjtY
         EaAJIhC92RVtHsHHtu3IEk8CRnX92cVDg8TVk63A1SadMlnNanxKWH39P0nAov6tNx/d
         7KMoirS5vjgPWVRkJwCmxWw5QyqCWlVk4g4t7M7f0qASeaJigq4eGI32VSYaKhUFmw2D
         x5uhcl+fFNmm5zyzhD3KZPPGBG1gqDkrHhKQ94+QTHCyyCKagcWWuFF5MMzz/hSFb052
         IgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713795341; x=1714400141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCVaFWgYPulgT/NxtvZ6t6tkYKya9dvfI35PAROfzCM=;
        b=AGKxuXdaQM/vFZZdcXgB7NBBBwuvxCOUIc2SDizggF1t6TOtcDULYAl/+iHnTNZODh
         bZ3Qaokhaz2/61viy1nOhcA2S5lZyAnvFvtDeyd3j7y3gPnWVoTmeOdmidDymBIVPFvJ
         VUTVk0nnQ18hM2ul3CTdnwh6i8TfTCmCIe2Fd+bOUKDN/2QsI0STS3N3X0DKnltAG3GT
         K9NHI+3r5sEnK9PHNXPiLrmo21565CCY56iUpdMhzPoOq/ZIEw7f777/rTYpQjbBfRrU
         P5kQ/1L1vk6ysGj9Y4ut3PYHcEYJYqTEX4X0UC8hGkI8yR+I+fNEydFOMsmVICE9YdcA
         ZI4A==
X-Forwarded-Encrypted: i=1; AJvYcCW9wNlZyafES1xJMjsthfXHBUTPURKm9xwnl2IqPAzQsMCeNhLDhF9Rh2Ez1tLLtUTFMw+YTttmmVRiBDgwuCdD07yFs6xBdkiljpM/bOUbfksMZ/lBI3z12sysiSdcjb4n+9bQ9d3hroW+IAel
X-Gm-Message-State: AOJu0YyAKI160Q04zgpOzV//WlK+tHS6CCMZfvszN8jv2oyBOhLnW9yo
	4xJMJrdfnkZt6iiKE/ErwuyHOJppT2wGqXGzHl23WijWL9qpRuIMQ/JMe/KS1bVOw/rCjVrRDbp
	oblS5SoJ8QKJkjdsKEaVH+HPWpzY=
X-Google-Smtp-Source: AGHT+IFbunRwSULX50t4Llpy7z9GbWeejxW1hudmJ11M2jBxAl6OxpCx/iw4uAPw2QnXpaAGy6vwFQFPQJCYpuptJpA=
X-Received: by 2002:a2e:90d0:0:b0:2dc:d7e7:d676 with SMTP id
 o16-20020a2e90d0000000b002dcd7e7d676mr5917610ljg.19.1713795341256; Mon, 22
 Apr 2024 07:15:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319154611.2492-1-johan+linaro@kernel.org>
 <ZiZdag8fw8H1haCb@hovoldconsulting.com> <438844e9-47e8-486e-9611-ae524d6974b3@quicinc.com>
 <ZiZkK4BAoqxNg7yG@hovoldconsulting.com> <472b9f60-d68e-47ee-9ca9-f71a9ba86a1a@quicinc.com>
 <ZiZpg4lyp-LcpV8l@hovoldconsulting.com> <3e170e40-c143-4e3b-8696-b661cac56f00@quicinc.com>
In-Reply-To: <3e170e40-c143-4e3b-8696-b661cac56f00@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Apr 2024 10:15:29 -0400
Message-ID: <CABBYNZKpR8ZqUHmLg0RLq1Yqtk4qDEYj9UuDLYrZsthSPao-dg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Bluetooth: qca: fix NULL-deref on non-serdev setup
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Zhengping Jiang <jiangzp@google.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Quic_zijuhu,

On Mon, Apr 22, 2024 at 9:53=E2=80=AFAM quic_zijuhu <quic_zijuhu@quicinc.co=
m> wrote:
>
> On 4/22/2024 9:43 PM, Johan Hovold wrote:
> > On Mon, Apr 22, 2024 at 09:30:28PM +0800, quic_zijuhu wrote:
> >> On 4/22/2024 9:20 PM, Johan Hovold wrote:
> >>> On Mon, Apr 22, 2024 at 09:04:58PM +0800, quic_zijuhu wrote:
> >>>> On 4/22/2024 8:51 PM, Johan Hovold wrote:
> >>>>> On Tue, Mar 19, 2024 at 04:46:09PM +0100, Johan Hovold wrote:
> >>>
> >>>>>> Johan Hovold (2):
> >>>>>>   Bluetooth: qca: fix NULL-deref on non-serdev suspend
> >>>>>>   Bluetooth: qca: fix NULL-deref on non-serdev setup
> >>>>>
> >>>>> Could you pick these up for 6.9 or 6.10?
> >>>>>
> >>>>> The patches are marked for stable backport and only privileged user=
s can
> >>>>> set the N_HCI line discipline these days (even if I'm not sure abou=
t
> >>>>> pre-5.14 kernels...) so it may be fine to wait for 6.10 if you pref=
er.
> >>>
> >>>> could you share the patch links for me to review. i can
> >>>> 't find them now
> >>>
> >>> Sure, but you should bookmark lore.kernel.org in your browser as you =
can
> >>> search the archives there yourself:
> >>>
> >>>     https://lore.kernel.org/lkml/20240319154611.2492-1-johan+linaro@k=
ernel.org/
> >
> >> NAK for your [PATCH 1/2] since the null checking is redundant with you=
r
> >> [PATCH 2/2].
> >
> > I explained in the cover letter why it is split up like this. If you
> > don't bother reading, then we will not bother listening to you.
> >
> >> NAK for your [PATCH 2/2], since it is same with my earlier fix
> >> https://lore.kernel.org/all/1704960978-5437-1-git-send-email-quic_ziju=
hu@quicinc.com/
> >> my new patchset for btattach tool still has this change.
> >
> > The fix does not depend on your btattach series, which has also been
> > rejected.
> >
> these my v1 and v2 for this issue which are earlier then yours.
> they are not rejected but not responded.
>
> https://lore.kernel.org/all/bf74d533-c0ff-42c6-966f-b4b28c5e0f60@molgen.m=
pg.de/
> https://lore.kernel.org/all/1704970181-30092-1-git-send-email-quic_zijuhu=
@quicinc.com/
>
> > You clearly have some learning to do on how to interact with the kernel
> > community and to write proper commit messages and patches. If you start
> > listening to feedback and try not to piss everyone off perhaps you can
> > even get your patches merged one day. [1][2]
> >
> > Johan
> >
> > [1] https://lore.kernel.org/linux-bluetooth/fbe5722b-1e45-4ccb-a050-20a=
473a823c8@quicinc.com/T/#m8e495666a71eb0e7ae54c82554dfff1fc96983e7
> > [2] https://lore.kernel.org/linux-bluetooth/1713563327-19694-1-git-send=
-email-quic_zijuhu@quicinc.com/T/#med0610646a8fd8b3c8586abca9895b124b2d2534
>

They probably need to be resend as well, you have so many sets pending
that makes it hard to know which should go first, next time please
wait until each set is merged before sending the next since I can't
know if they are really independent of each other or not.

--=20
Luiz Augusto von Dentz

