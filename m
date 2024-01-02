Return-Path: <linux-kernel+bounces-14215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F86821934
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47AAA1C209A5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB737CA78;
	Tue,  2 Jan 2024 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuX4xBfi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E8279F3;
	Tue,  2 Jan 2024 09:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E47C433C8;
	Tue,  2 Jan 2024 09:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704189333;
	bh=s0bfy0zMzuqlHQvLgQ1A1pV6d/4gZtKj+3zV9Q3CF14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QuX4xBfi4ctJbX2dP9VR3MK79f9E62WHlb3lnQ57nlVgU+JxP2Ej95YvlUJXT5ER9
	 5qhj9rBxTsvnsTgd/cXNyAJO0Wa5UIlFnl36trUozGNqoNmUFA+3x0izcWsYWa1jkS
	 RMq00l8zxwCKuvyN4pc+R2OhHNngF8xi5pSpf7VXgTM8yqld2baDymsgyAasR55G0s
	 zaLVXrcwOyO/WY87+v9Y7k7hcbW0jhFW+RfEU4wTXPt0hYQzXawX+tDxpXM012yQzK
	 oZPJ/u5TF/+3rNWCzRB/2XtQWDILMYi9KouMIEb64NTitWBHrs/ORH+Wh3t/1jO3BM
	 QY5vXvmTC5xTA==
Date: Tue, 2 Jan 2024 11:55:29 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Shachar Kagan <skagan@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
	Ido Kalir <idok@nvidia.com>, Topaz Uliel <topazu@nvidia.com>,
	Shirly Ohnona <shirlyo@nvidia.com>,
	Ziyad Atiyyeh <ziyadat@nvidia.com>
Subject: Re: Bug report connect to VM with Vagrant
Message-ID: <20240102095529.GE6361@unreal>
References: <MN2PR12MB44863139E562A59329E89DBEB982A@MN2PR12MB4486.namprd12.prod.outlook.com>
 <CANn89iKvG5cTNROyBF32958BzATfXysh4zLk5nRR6fgi08vumA@mail.gmail.com>
 <MN2PR12MB4486457FC77205D246FC834AB98BA@MN2PR12MB4486.namprd12.prod.outlook.com>
 <CANn89i+e2TcvSU1EgrVZRUoEmZ5NDauXd3=kEkjpsGjmaypHOw@mail.gmail.com>
 <cdf72778-a314-467d-8ac8-163d2007fd70@leemhuis.info>
 <20231227083339.GA6849@unreal>
 <CANn89iK_Q38g1ieEb1MVvmVgiKQxmv9Hzngu_pCcXcwGs7cPLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iK_Q38g1ieEb1MVvmVgiKQxmv9Hzngu_pCcXcwGs7cPLQ@mail.gmail.com>

On Tue, Jan 02, 2024 at 10:49:58AM +0100, Eric Dumazet wrote:
> On Wed, Dec 27, 2023 at 9:33 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Dec 15, 2023 at 10:55:05AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> > > On 08.12.23 11:49, Eric Dumazet wrote:
> > > > On Thu, Dec 7, 2023 at 2:03 PM Shachar Kagan <skagan@nvidia.com> wrote:
> > > >>>> On Thu, Nov 30, 2023 at 2:55 PM Shachar Kagan <skagan@nvidia.com> wrote:
> > > >>>>
> > > >>>> I have an issue that bisection pointed at this patch:
> > > >>>> commit 0a8de364ff7a14558e9676f424283148110384d6
> > > >>>> tcp: no longer abort SYN_SENT when receiving some ICMP
> > > >>>
> > > >>> Please provide tcpdump/pcap captures.
> > > >>>
> > > >>>  It is hard to say what is going on just by looking at some application logs.
> > > >>
> > > >> I managed to capture the tcpdump of ‘Vagrant up’ step over old kernel and new kernel where this step fails. Both captures are attached.
> > > >> The tcpdump is filtered by given IP of the nested VM.
> > > >
> > > > I do not see any ICMP messages in these files, can you get them ?
> > > >
> > > > Feel free to continue this exchange privately, no need to send MB
> > > > email to various lists.
> > >
> > > Here this thread died, so I assume this turned out to be not a
> > > regression at all or something like that? If not please speak up!
> >
> > No, it wasn't fixed and/or reverted. Right now, Vagrant is broken and
> > all our regressions around nested VM functionality doesn't run.
> >
> > Eric, can you please revert the bisected patch while you are continuing
> > your offline discussion with Shachar?
> >
> 
> This is not how things work.
> 
> I have not received any evidence yet, only partial packet dumps with
> no ICMP messages that could be related to the 'Vagrant issue'

Revert of the original patch worked, so it is strong enough evidence to do
not break very popular orchestration software.

> 
> Patch is adhering to the RFC.
> 
> If an application wants to have fast reaction to ICMP, it must use
> appropriate socket options instead of relying on a prior
> implementation detail.

Maybe yes, maybe not. Right now, Vagrant is broken.

Thanks

