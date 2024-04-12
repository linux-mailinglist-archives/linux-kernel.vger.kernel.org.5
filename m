Return-Path: <linux-kernel+bounces-142683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71C18A2ECC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6303E283958
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AC35B694;
	Fri, 12 Apr 2024 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="PRmS83iZ"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DA15D903;
	Fri, 12 Apr 2024 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927158; cv=none; b=RKtusDDk15oVLn/qP35WbchbUxZ7KnpRMU0J1PabcTIBzDANK7kWOPz5Wrgljii7pCkJhSJ25LiICLHx9oTOSmH2O9kiOk93JhZgcRFlmV0SZb78crlO8qEf9dL39f226Is5H4ccKk2mMThzF71LtKJP9Nr7HKVKglGNYmHbD20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927158; c=relaxed/simple;
	bh=Ss4pa3fxOvv47wLjK5xI1USUArEmeU0P6XfU8eItOkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLe6oXyQ2mQUCkOdKIveKZJQtMOZ6e8oFljx36K4S4yVp9GZbyZ/z9WU6JDq1JbOjj6a0WOfosC4P0huFrVAob7MInGSp9lgPqaULLQqgbmbiovS1rr0pB7d+TIZhhKy0O++FzZhtMTe3XFfU5kf7TUi0gUZMIWM7De61qMfY1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=PRmS83iZ; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1712927144; x=1713531944; i=parker@finest.io;
	bh=w7ezEgQol+8NGxCB/VCha44+KwHcA5KILx0IeNxoxKo=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:
	 References;
	b=PRmS83iZnp1BceqYNVoAWbcTNseEgl6Nj4NVOQfkACBJ7dD+x563x0HKpuZhqAtL
	 xtB2BfJKmlXJBXisnPX2NpSdTv5Hipl8dLZgX0dBCboVrLpaBm4R0G89b3zxpbQoK
	 HrRmIgFthmmRDYA5ecVIImhi/Ci1XnRmvnwMH5BQtu0SL+hHAiNZe8RvhJsRaWGtv
	 JGa47mXb9FiP8ln25EKcpnPhdvRwBzSBB51B1lmvh/wdp2PubTInh2BPloChc+CAg
	 HD/rEnHtbWRD6BkhSu+0Fz85LYHnObkh864HM0Nk0zjH5AfhDvGIGM5vbT4R7+LHC
	 N2RnRWQc4hAFggFOXA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0McUbu-1sCw0V3I8W-00He1w; Fri, 12 Apr 2024 15:05:43 +0200
Date: Fri, 12 Apr 2024 09:05:42 -0400
From: Parker Newman <parker@finest.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 3/7] serial: exar: add support for config/set single
 MPIO
Message-ID: <20240412090542.3d86d9a9@SWDEV2.connecttech.local>
In-Reply-To: <2024041213-uncouple-justness-35fa@gregkh>
References: <cover.1712863999.git.pnewman@connecttech.com>
	<3e671b6c0d11a2d0c292947675ed087eaaa5445e.1712863999.git.pnewman@connecttech.com>
	<2024041213-uncouple-justness-35fa@gregkh>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+aHuG4nQtoEdrPgtvM3jLPJyWxuMLanaHejkmrFYdcKMhfcoGIH
 tLoLxv/R1t7hL2k6MRjikyGdoozDvDn5PDsjxi3Hz90GKfBI9UtHN0vxEGY+r6Ryw2utuOU
 wbtVHTTd7sKSHgN9C8yBp+BRTzwaJlbN8vZGFiMlzXdpk6XaLDAnkbreUpbBkvyP+upKnNk
 WB7JOBk/EBjhbKFF9bxnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SPAAKHEVAv4=;uEzgGm3I/JbeLDXKSjUOXpxc1mm
 AvKl335kOAlJq5QFYh0tGjUOgX9gbHWWPdq4rJJQHoJFOrTgk4359Y3PaLL1bTXwPiRoJLEPm
 PaOb8kWCpzsyFrminAWmT1ivh0Rr+/XB7IO9vgk0Rtn/qorGuTAK3m47KA+8DDKdjpzniC97T
 QM6ejIsqdvc8JvPXnvoem/OFp+vgK/lGy2E5ruNVDn6ms+ci2x1TE9kFWZACz8iwQ1YwrzAml
 lXv7gkWxW6AO9lepGgA+ynKPnsIrgJzvSRxne7BLywUt4+4HSoYreEICJyZGAg36JVcTWz9NV
 eh4i3TWVXNzKXXhH61VNsVorLm6gy9RICq+rapvW9aznOnugUE/jgk5XFy+tFi+FuDzZoC+sk
 Wdwi6OZ3aF76z3gRPAP6L+LDJ2GHPgOvHXRbNx2m5X9YiAc5EKdqY7jUr1W+42XA9UkK5wmjG
 RkafAAWaeZFGqIezn2zJKJlA6qUYQGB0GiU5NUMH0Ut3vquLfnJzdH0L+/wxAHogss4SIBtGn
 jqwETgK2CdFLAx0EpZdicQr5+JdVkF4/HolsSymYNI6zp5Om4KGvEdwE2lI5gzaY9LcItZHO1
 L0yhk9lxxkxhFsnwqzYbNc4HlNd6stu1LiO7ryEqXamA2MI/CXPaqWYccbt2lEGiuAjmAuZc5
 UCy8VeYdNr0x/NCg/DPCfYINb4le8eefdRpC4D/1Zfxef4OOz/5CrRkwgE4hALvlaV8xN71rG
 ONTa85Zg6ALZjxTbQivw7eB6kDK4Eirw2pNRzruSfOZ+GW1drMjAqE=

On Fri, 12 Apr 2024 07:29:16 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Apr 11, 2024 at 04:25:41PM -0400, parker@finest.io wrote:
> > +/**
> > + * exar_mpio_config() - Configure an EXar MPIO as input or output
> > + * @priv: Device's private structure
> > + * @mpio_num: MPIO number/offset to configure
> > + * @output: Configure as output if true, inout if false
> > + *
> > + * Configure a single MPIO as an input or output and disable trisate.
> > + * If configuring as output it is reccomended to set value with
> > + * exar_mpio_set prior to calling this function to ensure default sta=
te.
> > + *
> > + * Return: 0 on success, negative error code on failure
> > + */
> > +static int exar_mpio_config(struct exar8250 *priv,
> > +			unsigned int mpio_num, bool output)
>
> When you have a bool in a function, every time you read the code you
> have to go and figure out what that boolean means.
>
> Have 2 functions:
> 	exar_mpio_config_input()
> 	exar_mpio_config_output()
>
> and then have THEM call this function with the bool set or not.  That
> way when reading the code you know exactly what is happening.
>
> Same with other functions in this patch.  Naming is hard, make it easy
> please.

Good feedback thanks.

> thanks,
>
> greg k-h


