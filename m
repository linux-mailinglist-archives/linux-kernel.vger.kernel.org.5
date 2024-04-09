Return-Path: <linux-kernel+bounces-136709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D051289D767
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16246B21C26
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DFA85641;
	Tue,  9 Apr 2024 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrEjQg7d"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D1383A08;
	Tue,  9 Apr 2024 10:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712660282; cv=none; b=jhLXHWymewAHLulDR90cjT4InqKevdOS7lYf+xbzNdEJ07iI3h6zkfnO4S5bpxSA5oj3ua0XX6nUpS0wgKqtHspfSmXNwry3vod418rzVdSNysjxjhQfTbzhljXfDPI/3xirMMr0CgJSldF7E9yeACcXmJGJHrgUv+fW7Q8EHc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712660282; c=relaxed/simple;
	bh=ya/MCMiaE1ggd5qVAUNHoR3erBVlClUkIgBYXaCFLUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfZMnYNNl4WBd0YsehSv2DJKqS7XpONzwQZpwV5ACe5psGEnC08ddpq1Z+JDCrmcdtvwcsyZ6KUduMrbMCwDBTfnH1c1KIGp6hDkAkae6CIZrXsBbiqjAlFFKKAWkXYDbJGCecL40gHWjsHpVorBcOzgO0G5OS2K/bfEjTukbA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrEjQg7d; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dd161eb03afso4795514276.0;
        Tue, 09 Apr 2024 03:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712660279; x=1713265079; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aZEsFzW9LRR0XJd7CjP0zKGx1rfiXxStLnGZA0bf4Nw=;
        b=mrEjQg7dbfA/IaGCZ4JICmeRIVQrX02cGg2N80hHGYBPbgoZ+7GsGVfMPiKZMzZzgv
         hAkA1fYpoLKNGs9vQixcsf8x0x6FNH86nMBAaRNP5//6hKgI9EufPkB7WS0/0EVr9Ey8
         /XLGhZ/QzWnVsgzh0DPqZG5qUInfxFSyf9yNVW8kq6WvsvmNklQ9UedkuuTWVk1aw8XJ
         SACh2vIwVCt00cLOtkjee7aDUFL8HjPxJJznT4KYdYZOsmvtfjiU9v7aAt6k0YqAqyIl
         F00dKRFHBXplzM3XBpyP+tTQFflb30XlA8gKZwhQ3ghfiVSnPgOey4A+d49fC2Gp74nL
         UyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712660279; x=1713265079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZEsFzW9LRR0XJd7CjP0zKGx1rfiXxStLnGZA0bf4Nw=;
        b=hkQK3Kzfu1r5X+3mIQorwS/c/B+nG/BlRsN9yxiA8vAMGnjTNj6jYgkY4p+fYkNUt0
         UuyR07rJuVV4lEcV+zu1u/WIUsOyyN+/XgHupyJi45eZ6Gli8ud4G71hL4j4pp+wv6IW
         Hj/DEgvTrvFWuxwG9MUOLzQfzd/MS6lHpDsR67a2X2fdl6KPQ2wY7FmxCWet0fhA086l
         kycnD8zwaAmoF22dSbwyDvzvQc+CU6tqu0tMnkDjAa2T9+jPLMBoj9uVlhZiNZWMFb95
         Ia+qZpcsoZ+rCQssHbLS+0/JQ4wih5bGWu6nrasNFy8RInl3tZ4M9YTeCJdi5wPmC44y
         f3bw==
X-Forwarded-Encrypted: i=1; AJvYcCWE3HJ+rIa/4S6rAz+TOJ/KlT4pa6WxQ2F1Me/lfOXT5eKFR857NSX+er8v0Mf+0oz34Tnuw73zWEyDKu4BGDk3Rls2y7e5bkfzxmuH8omFt3MPJ1YEZKmIrC3evRcIMrH2Py/G/cKJCyQ=
X-Gm-Message-State: AOJu0YyJvRJYx9UGxC3d90LeLSDw+bfkAPsjiUYrtrBnE8XAGLEvB1vS
	kIdz7I3v8zUfnK0UNIK3saX0gX4EVJseHXDZeFL9eyDpxdavP4rWi/fzTMbdOq/zlLkv6NadNpE
	UW67FzeolVU880JkrU6/8hLcF9uc=
X-Google-Smtp-Source: AGHT+IHk8vzL6Rj9EH+UpigARhru0dj56fO8DLqAIhRSdY6MaOWN9mqgHKht5kCPaBqcwNz6sgVuYTonTH7cPUYMQl8=
X-Received: by 2002:a05:6902:1d0:b0:dcc:1062:47c0 with SMTP id
 u16-20020a05690201d000b00dcc106247c0mr8231890ybh.56.1712660279410; Tue, 09
 Apr 2024 03:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZhFJZoful6nEFskW@archie.me> <4d231dc4-0183-47e1-8bfa-3dd225bf8ea3@leemhuis.info>
 <904ffa11-592a-4336-aed2-d6370bb01896@collabora.com> <b99e51de-3622-4360-b69d-0fd911ea2a7d@leemhuis.info>
 <9012f8d5-302a-4840-815a-22b1e85fda5c@collabora.com> <c0193bca-ea80-49eb-ab26-8256d07078df@leemhuis.info>
 <41b7170d-65b8-4d64-a1d3-7a0d09d79c45@collabora.com> <fa076f6f-5a19-4a6a-aaf4-8d9e36df8fea@leemhuis.info>
 <682dfcc5-056c-4170-910b-64ae42370c52@collabora.com>
In-Reply-To: <682dfcc5-056c-4170-910b-64ae42370c52@collabora.com>
From: Daniel Martin <dmanlfc@gmail.com>
Date: Tue, 9 Apr 2024 20:57:48 +1000
Message-ID: <CAOyTmd0OWyOJGK3b5J322Ftxz=S8_qRmO=aC7mMeYXe76=w+Mg@mail.gmail.com>
Subject: Re: Fwd: Steam Deck OLED 6.8.2 nau8821-max fails
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Arun Gopal Kondaveeti <arungopal.kondaveeti@amd.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Sound System <linux-sound@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

The manual patches were worked from the Steam Deck kernel, trial &
error with partial support in 6.6 at the time.
6.8 sources where this has been implemented recently were not yet
available or in linux-next.
Suffice to say the code matches up almost perfectly apart from the
enum issues which are thus being discussed.
I still go back to the point, apart from the Steam Deck, who else is
using this named topology file?
I don't think anyone is, therefore the enum numbering should match the
current Steam Deck kernel implementation & topology file.


On Tue, 9 Apr 2024 at 19:55, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>
> On 4/9/24 12:19 PM, Linux regression tracking (Thorsten Leemhuis) wrote:
> > On 09.04.24 10:47, Cristian Ciocaltea wrote:
> >> On 4/9/24 11:04 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
> >>> On 09.04.24 09:42, Cristian Ciocaltea wrote:
> >>>> On 4/9/24 7:44 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
> >>>>> On 09.04.24 01:44, Cristian Ciocaltea wrote:
> >>>>>> On 4/7/24 10:47 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
> >>>>>>> On 06.04.24 15:08, Bagas Sanjaya wrote:
> >>>>>>>> On Bugzilla, Daniel <dmanlfc@gmail.com> reported topology regression
> >>>>>>>> on Steam Deck OLED [1]. He wrote:
> >>>>>>
> >>>>>>>>> I'm adding this here, I hope it's the correct place.
> >>>>>>>>> Currently the Steam Deck OLED fails with Kernel 6.8.2 when trying to initialise the topology for the device.
> >>>>>>>>> I'm using the `sof-vangogh-nau8821-max.tplg` file from the Steam Deck OLED and associated firmware.
> >>>>>>>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218677
> >>>>>>> A quick search made me find these posts/threads that foreshadow the problem:
> >>>>>>>
> >>>>>>> https://lore.kernel.org/lkml/20231219030728.2431640-1-cristian.ciocaltea@collabora.com/
> >>>>>>> https://lore.kernel.org/all/a3357e1f-f354-4d4b-9751-6b2182dceea6@amd.com/
> >>>>>>>
> >>>>>>> From a quick look at the second discussion it seems a bit like we are
> >>>>>>> screwed, as iiutc topology files are out in the wild for one or the
> >>>>>>> other approach. So we might have to bite a bullet there and accept the
> >>>>>>> regression -- but I might easily be totally mistaken here. Would be good
> >>>>>>> in one of the experts (Venkata Prasad Potturu maybe?) could quickly
> >>>>>>> explain what's up here.
> >>>>>>
> >>>>>> The problem here is that Steam Deck OLED provides a topology file which
> >>>>>> uses an incorrect DAI link ID for BT codec.
> >>>>>>
> >>>>>> Patch [1] moves BT_BE_ID to position 2 in the enum, as expected by the
> >>>>>> topology, but this is not a change that can be accepted upstream as it
> >>>>>> would break other devices which rely on BT_BE_ID set to 3.
> >>>>>>
> >>>>>> The proper solution would be to update the topology file on Steam Deck,
> >>>>>> but this is probably not straightforward to be accomplished as it would
> >>>>>> break the compatibility with the currently released (downstream)
> >>>>>> kernels.
> >>>>>>
> >>>>>> Hopefully, this sheds some more light on the matter.
> >>>>>>
> >>>>>> [1]: https://lore.kernel.org/all/20231209205351.880797-11-cristian.ciocaltea@collabora.com/
> >>>>>
> >>>>> Many thx, yes, this sheds some light on the matter. But there is one
> >>>>> remaining question: can we make both camps happy somehow? E.g. something
> >>>>> along the lines of "first detect if the topology file has BT_BE_ID in
> >>>>> position 2 or 3 and then act accordingly?
> >>>>
> >>>> Right, I have this on my TODOs list but haven't managed to dig into it
> >>>> yet. However, that would be most likely just another hack to be carried
> >>>> on until the transition to a fixed topology is completed.
> >>>
> >>> Well, sure it's a hack, but the thing is, our number one rule is "no
> >>> regressions" and the reporter apparently faces one (see start of the
> >>> thread). So to fulfill this rule it would be ideal to have a fix
> >>> available soonish or revert the culprit and reply it later together with
> >>> the fix.
> >>
> >> Hmm, unless I'm missing something, this shouldn't been considered a
> >> regression.  As I explained previously, the OLED model was launched with
> >>  a downstream implementation of the Vangogh SOF drivers on top of v6.1,
> >> as there was no upstream support back then.
> >>
> >> When AMD eventually completed the upstreaming process of their SOF
> >> drivers in v6.6, we ended up with this unfortunate ID assignments
> >> incompatibility.  Hence I cannot see how the mainline kernel would have
> >> worked without applying patch [1] above, unless the reporter
> >> experimented with a different topology (which is not the case if I got
> >> this right).
> >>
> >>> Do we know which change that went into 6.8 caused this? Or is a revert
> >>> out-of-the question as it will likely break things for other users that
> >>> already upgraded to 6.8 and have a matching topology file? (/me fears
> >>> the answer to the latter question is "yes", but I have to ask :-/)
> >>
> >> We need to understand how the reporter got this working with mainline
> >> kernels without applying any out-of-tree patches.
> >
> > Ahh, okay, thx, now I understand this better. You are most likely
> > correct. It also made me look at the initial report again where I
> > noticed "When *I manually patched support* for the 6.6 or 6.7 mainline
> > kernel it worked fine.", so yes, this likely is not a regression.
>
> It would be interesting to find out what the *manually patched support*
> involved. FWIW, to get audio working with v6.8, it's also necessary to
> backport several patches from v6.9-rc1 - I would consider the following:
>
> Fixes: f0f1021fc9cb ("ASoC: amd: acp: Drop redundant initialization of machine driver data")
> Fixes: 68ab29426d88 ("ASoC: amd: acp: Make use of existing *_CODEC_DAI macros")
> Fixes: d0ada20279db ("ASoC: amd: acp: Add missing error handling in sof-mach")
> Fixes: 222be59e5eed ("ASoC: SOF: amd: Fix memory leak in amd_sof_acp_probe()")
> Fixes: a13f0c3c0e8f ("ASoC: SOF: amd: Optimize quirk for Valve Galileo")
> Fixes: 369b997a1371 ("ASoC: SOF: core: Skip firmware test for custom loaders")
> Fixes: d9cacc1a2af2 ("ASoC: SOF: amd: Compute file paths on firmware load")
> Fixes: 33c3d8133307 ("ASoC: SOF: amd: Move signed_fw_image to struct acp_quirk_entry")
> Fixes: 094d11768f74 ("ASoC: SOF: amd: Skip IRAM/DRAM size modification for Steam Deck OLED")
>
> I think most if not all of the mandatory fixes from the list above have been
> already included in the latest v6.8 stable updates, but I haven't actually
> tested.
>
> >
> > Thx for your help and sorry for the trouble I caused!
>
> No problem at all!
>
> Regards,
> Cristian



-- 

Kind Regards,

Daniel
+61 (0)409611884

