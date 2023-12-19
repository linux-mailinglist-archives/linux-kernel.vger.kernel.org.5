Return-Path: <linux-kernel+bounces-5404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28E8818A51
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D851B1C248F2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CDE1C6B4;
	Tue, 19 Dec 2023 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0tuLIkT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF5ED2FC;
	Tue, 19 Dec 2023 14:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A3FC433C8;
	Tue, 19 Dec 2023 14:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702996935;
	bh=eBFadiHuXwmJfGGqWpIvFNr/M7Pv8cI/lMfcRTLRiAM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=c0tuLIkTYsPGnlHcAqYGRIeFk6q49PcnQUqZOMVID722iDuTnl3CMxcCyNKxZRWSd
	 F1aDctTLeA3ISQgMRhwWd5JHEY3nrLGTKwLAYYnKPIUW3tfpDjQZabLBjEE15ZE1/+
	 xtI4oerLSn8apddbF1b3bpT4bvopRC1LhkyFDWLkekXOP2t3mP/khcxYe28XbBCU6c
	 jdvY+ZUoS9wzXJ6So72ILzPHJ2ZGCc6914ATV77RuFod3WHGEmUuMj2jXEiOpej4eb
	 WR+Mnqgvvdrle+eHgqkbh/Q9JSQe6HrPxPXJsjAIyNWlwXpWo+PdiPRW0liPAJl6lp
	 saiKTvmDjuaoQ==
From: Kalle Valo <kvalo@kernel.org>
To: Daniel Berlin <dberlin@dberlin.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,  Arend van Spriel
 <aspriel@gmail.com>,  Franky Lin <franky.lin@broadcom.com>,  Hante
 Meuleman <hante.meuleman@broadcom.com>,  Hector Martin <marcan@marcan.st>,
  SHA-cyfmac-dev-list@infineon.com,  asahi@lists.linux.dev,
  brcm80211-dev-list.pdl@broadcom.com,  linux-kernel@vger.kernel.org,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
	<170281231651.2255653.7498073085103487666.kvalo@kernel.org>
	<18c80d15e30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
	<1b51997f-2994-46e8-ac58-90106d1c486d@marcan.st>
	<c392f901-789a-42e2-8cf7-5e246365a1ca@broadcom.com>
	<CAF4BwTXNtu30DAgBXo4auDaDK0iWc9Ch8f=EH+facQ-_F-oMUQ@mail.gmail.com>
Date: Tue, 19 Dec 2023 16:42:10 +0200
In-Reply-To: <CAF4BwTXNtu30DAgBXo4auDaDK0iWc9Ch8f=EH+facQ-_F-oMUQ@mail.gmail.com>
	(Daniel Berlin's message of "Tue, 19 Dec 2023 08:07:16 -0600")
Message-ID: <87r0jiqmnx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Berlin <dberlin@dberlin.org> writes:

> On Tue, Dec 19, 2023 at 7:46=E2=80=AFAM Arend van Spriel <arend.vanspriel=
@broadcom.com> wrote:
>
>  On 12/19/2023 12:01 PM, Hector Martin wrote:
>  >=20
>  >=20
>  > On 2023/12/19 17:52, Arend Van Spriel wrote:
>  >> On December 17, 2023 12:25:23 PM Kalle Valo <kvalo@kernel.org> wrote:
>  >>
>  >>> Hector Martin <marcan@marcan.st> wrote:
>  >>>
>  >>>> Using the WSEC command instead of sae_password seems to be the supp=
orted
>  >>>> mechanism on newer firmware, and also how the brcmdhd driver does i=
t.
>  >>>>
>  >>>> According to user reports [1], the sae_password codepath doesn't ac=
tually
>  >>>> work on machines with Cypress chips anyway, so no harm in removing =
it.
>  >>>>
>  >>>> This makes WPA3 work with iwd, or with wpa_supplicant pending a sup=
port
>  >>>> patchset [2].
>  >>>>
>  >>>> [1] https://rachelbythebay.com/w/2023/11/06/wpa3/
>  >>>> [2] http://lists.infradead.org/pipermail/hostap/2023-July/041653.ht=
ml
>  >>>>
>  >>>> Signed-off-by: Hector Martin <marcan@marcan.st>
>  >>>> Reviewed-by: Neal Gompa <neal@gompa.dev>
>  >>>
>  >>> Arend, what do you think?
>  >>>
>  >>> We recently talked about people testing brcmfmac patches, has anyone=
 else
>  >>> tested this?
>  >>
>  >> Not sure I already replied so maybe I am repeating myself. I would pr=
efer
>  >> to keep the Cypress sae_password path as well although it reportedly =
does
>  >> not work. The vendor support in the driver can be used to accommodate=
 for
>  >> that. The other option would be to have people with Cypress chipset t=
est
>  >> this patch. If that works for both we can consider dropping the
>  >> sae_password path.
>  >>
>  >> Regards,
>  >> Arend
>  >=20
>  > So, if nobody from Cypress chimes in ever, and nobody cares nor tests
>  > Cypress chipsets, are we keeping any and all existing Cypress code-pat=
hs
>  > as bitrotting code forever and adding gratuitous conditionals every ti=
me
>  > any functionality needs to change "just in case it breaks Cypress" even
>  > though it has been tested compatible on Broadcom chipsets/firmware?
>  >=20
>  > Because that's not sustainable long term.
>
>  You should look into WEXT just for the fun of it. If it were up to me=20
>  and a bunch of other people that would have been gone decades ago. Maybe=
=20
>  a bad example if the sae_password is indeed not working, but the Cypress=
=20
>  chipset is used in RPi3 and RPi4 so there must be a couple of users.
>
> None of this refutes what he said
>
> We already know it doesn't work for the rpi3/4 users because they are
> blogging about it. The fact that you (not personally but as a
> maintainer) don't know what works for who or doesn't is part of the
> issue. Who are the users who this is for, how are you getting feedback
> on what is working or not, how are you testing that it stays working?
>
> I'm with Hector - this approach has mainly resulted in a driver that
> kind of works for some people with no rhyme or reason - but nobody
> knows who and what works for them. This isn't sustainable. You need
> testing and feedback loops from some defined populations.
>
> Of course, This will all become moot as we argue about it - more and
> more is breaking for more and more people (for example, management
> frames are totally broken on newer chips because we silently assume
> version 1).
>
> The driver is about one real upgrade cycle away from not working, in
> current form, for the vast majority of its users.
>
> One would hope we don't sit and argue about how to support the future
> while waiting for that to happen, instead we should be moving the
> driver forward. If we need to worry about specific older chip users,
> we should name who they are, how many there are, and what the limits
> of support are. We should then talk about the best way to support them
> while still moving the world forward.

Why is it that every patch Hector submits seems to end up with flame
wars? Look, we have a lot to do and please understand that our time is
limited. PLEASE listen to the review feedback and try to fix the patches
for the next review round, so that we can get this patch applied and
move forward.

And also these "we know better than you do" comments from people who
clearly are not really familiar with Linux wireless project, or even
kernel development, are not helping. Especially if it's in an HTML mail
(which our lists automatically drop).

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

