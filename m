Return-Path: <linux-kernel+bounces-120742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC38088DC65
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C281F2D7F1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2CF5A115;
	Wed, 27 Mar 2024 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="CGUw99V0"
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B493359B63
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711538473; cv=none; b=h8YZSmZPY2xAWXUK9chnyWKx7J/cK/105/9ph7p/n4owb3RcZP+GBaHtKDGhkb7BdZ3bZiKzTXZE8va4+tdmMfSPiAHzKXFM3/j6VY+yz6PzIaZiSC3A6s61oiuSHpnqV50Uo53hK3jc+ZqaqRu9F2VkBic8yCv370pYvDBHHJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711538473; c=relaxed/simple;
	bh=FGUoqKxAQrqnoBrdwR+KD2Oip1GwaKOaioEDRMyB75o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M9N1jOY7ClLErR+4afvWQrJwB2DNgtuxRmz/mEUcD4QjA/hJq9erzCcwdc4KZr3NmPY9YUBSu4p2iP1muuxkwcpY//qT3UiM+ACTMgqyUTrDns/CGuOJCKTHCp5sZoXNCCGMxGfyUYD27Ztk1ea/rHwH+2bhZuxb26PWyk3+AJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=CGUw99V0; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240327112102c3f78d6866e00f3efa
        for <linux-kernel@vger.kernel.org>;
        Wed, 27 Mar 2024 12:21:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=FGUoqKxAQrqnoBrdwR+KD2Oip1GwaKOaioEDRMyB75o=;
 b=CGUw99V0HjizVNE3UApeXPD9+uHHhXmsyZEYTUgE0MzTD4w1Ozpmo4TFQYF8JQH0iggT0x
 QFWgSKmbprLsTPXnbQNXgj8wqlD6W8TbXgIU71ZoghtuBRT1gnSqTZW9Dee668Vuhvc6h0ls
 wzj5DDPanluAH3AB7DEsFcAseISXY=;
Message-ID: <ab114fcc84c50723bb88d40ccbbeedf7b48dbe0e.camel@siemens.com>
Subject: Re: [xdp-hints] Re: [PATCH iwl-next,v4 1/1] igc: Add Tx hardware
 timestamp request for AF_XDP zero-copy packet
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>, Kurt Kanzenbach
 <kurt@linutronix.de>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@google.com>, "Gomes, Vinicius" <vinicius.gomes@intel.com>,
 "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,  "xdp-hints@xdp-project.net"
 <xdp-hints@xdp-project.net>
Date: Wed, 27 Mar 2024 12:21:01 +0100
In-Reply-To: <PH0PR11MB583028B2023E1E809B45B51DD8352@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <20240325020928.1987947-1-yoong.siang.song@intel.com>
	 <d2623ac0f1cb07a23976416cdcf9eee1986747b0.camel@siemens.com>
	 <87h6gtb0p0.fsf@kurt.kurt.home>
	 <PH0PR11MB583028B2023E1E809B45B51DD8352@PH0PR11MB5830.namprd11.prod.outlook.com>
Autocrypt: =?US-ASCII?Q?addr=3Dflorian.bezdeka@siemen?=
 =?US-ASCII?Q?s.com;_prefer-encrypt=3Dmutual?=
 =?US-ASCII?Q?;_keydata=3DmQENBFwsf8QBCAC2f4AQWu92LZC4bKyUYRxWIpWqGz790s?=
 =?US-ASCII?Q?pcYkXO7M8kfea4iC8qMxv2hT4HT0LTncRP6WiovVN2PeoOBfN5BSa5z?=
 =?US-ASCII?Q?LIrZGVXh7KmbdKhwhVU+ynoTq9G5uaO2Kos7Vv7nNCuatIq8tSNILuoB?=
 =?US-ASCII?Q?DFTAZnJW3y1V7YOwhDCPl5gbLSYqUY3OE0yksbtCcVI5istT4ED6mjQ?=
 =?US-ASCII?Q?9W+3uH1LrgFeEF0oxTjrEPxO5ZYATz0f/TYC8WiM0sMrV+n0eMDntlzA?=
 =?US-ASCII?Q?63D6lcRi5mNp2jPsJkq3tbWqyCrAe1sKPVJB44ekFwCk0kDIuhR13Q3R?=
 =?US-ASCII?Q?HE4Or/9sznhMUQjYueWXvTZfzH/VsQJHABEBAAG0LUZsb3JpYW4gQmV6?=
 =?US-ASCII?Q?ZGVrYSA8Zmxvcmlhbi5iZXpkZWthQHNpZW1lbnMuY29tPokBVAQTAQg?=
 =?US-ASCII?Q?APhYhBAzL4P3jiTHdthsq4cj0O1fnOEBVBQJcLH/FAhsDBQkB4TOABQs?=
 =?US-ASCII?Q?JCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEMj0O1fnOEBVc6YIAJ8oO4x?=
 =?US-ASCII?Q?TjOCpjxaS8XQE6VW50HE9I6ShbQVWUEGhF4qzJaACTQDjdg/aio7qNRa?=
 =?US-ASCII?Q?mnAy83Hy9sAxKVhXs+1R1fstN+JO8zgD3tJspucUkCiXlYu+Qcv2d6C?=
 =?US-ASCII?Q?ostv+h4nv8fkSoeLfsQu3GJt6W0RN7t+8H/9fUMXyuB8GWo4bhaZcti6?=
 =?US-ASCII?Q?78CotGLs6UGZpYEGiAMto8+9zVO/tdY1BkREM6bCVeQ9FnnpTRQy/tU5?=
 =?US-ASCII?Q?xemMWJI64UUP92TUIbQ3TZKAz4iG/Mle+YjiHBGrJM7TxjE3sDg5J2Fa?=
 =?US-ASCII?Q?HX4wmZPKGdB6wANKupf6HMMt2y7gduVmMKzgb8PDMLPZwWBSvjELQqz?=
 =?US-ASCII?Q?hiZAQ0EYLSqZwEIAIR4HMTQC4F4YxatIl6MIDY03zD4M3ZQpgyQ6QFL9?=
 =?US-ASCII?Q?Dq0I+PGc7A6z5rsGl76+D8pDFSN2BBJiLLlQadxKc3ZyTTlRp4bc=09bf?=
 =?US-ASCII?Q?FZRmsAXwVfLtBauXxGo9pkyhk8Vcjb2EJm6XR8PH99buGOXlFfTLsmeA?=
 =?US-ASCII?Q?ji/F4jU3qlUnwZMBvHZwRSFqOGdwKPMvW3FppfmREQ0o4xJ4b/bxGXx?=
 =?US-ASCII?Q?ko21uyR/S5rEJx6X8Ukw95h3JinXHx/g2cjbKHrWBDKoqtX9IZCamDny?=
 =?US-ASCII?Q?R+sfLWQbOKOrLNYLwLAQwOTVlZWTgue10G1q6Zi0r8RQ2T1Uy+ZLYagv?=
 =?US-ASCII?Q?Cbzp/lT7p3mv3ba68llX896c0AEQEAAbQ/QmV6ZGVrYSwgRmxvcmlhbj?=
 =?US-ASCII?Q?sgQmV6ZGVrYSBGbG9yaWFuIDxmbG9yaWFuLmJlemRla2FAc2llbWVuc?=
 =?US-ASCII?Q?y5jb20+iQEcBBABCAAGBQJgtKpnAAoJEEoHyE9rG1dPpJYH+gPnqpu7h?=
 =?US-ASCII?Q?4fsWOxco38e74MsazoUdfndTYP5tgaYTVE51ZhOZBl+4jYaywsmmFm9g?=
 =?US-ASCII?Q?6N4Tw3GiMEDB4YU1X7gQZ60fDKpYL5SnCu5qZirJ4RCV4LDA0789ir+6?=
 =?US-ASCII?Q?8/zfwXBTV5QoMH0+MkXB4BL+Km3f7X/GdN5oRoItAyKDBcEfGJo6afT?=
 =?US-ASCII?Q?PtcUdI9n7ExCSfJwb0SBvvkvUsdNppFDGOOHSioINbEHBs2VUvE43toM?=
 =?US-ASCII?Q?4mPLfhFIAtDcn5Byt80/kotU8v3Iyf86NYCa+0h77xTsKHcCUqe8Rvow?=
 =?US-ASCII?Q?bCIbig9GGbbd54TasfqQQOiAkn/WeGl33+UIVX1Q8zo7eyMJHzLJQ3I=3D?=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Tue, 2024-03-26 at 14:55 +0000, Song, Yoong Siang wrote:
> On Tuesday, March 26, 2024 9:08 PM, Kurt Kanzenbach <kurt@linutronix.de> =
wrote:
> > Hi Florian,
> >=20
> > On Tue Mar 26 2024, Florian Bezdeka wrote:
> > > On Mon, 2024-03-25 at 10:09 +0800, Song Yoong Siang wrote:
> > > > This patch adds support to per-packet Tx hardware timestamp request=
 to
> > > > AF_XDP zero-copy packet via XDP Tx metadata framework. Please note =
that
> > > > user needs to enable Tx HW timestamp capability via igc_ioctl() wit=
h
> > > > SIOCSHWTSTAMP cmd before sending xsk Tx hardware timestamp request.
> > > >=20
> > > > Same as implementation in RX timestamp XDP hints kfunc metadata, Ti=
mer 0
> > > > (adjustable clock) is used in xsk Tx hardware timestamp. i225/i226 =
have
> > > > four sets of timestamping registers. *skb and *xsk_tx_buffer pointe=
rs
> > > > are used to indicate whether the timestamping register is already o=
ccupied.
> > >=20
> > > Let me make sure that I fully understand that: In my own words:
> > >=20
> > > With that applied I'm able to get the point in time from the device
> > > when a specific frame made it to the wire. I have to enable that
> > > functionality using the mentioned ioctl() call first, and then check
> > > the meta area (located in the umem right before the frame payload)
> > > while consuming the completion queue/ring. Correct?
>=20
> Hi Florian,
>=20
> Yes, you are right. But before you pass the frame to driver, make sure
> you request Tx metadata hardware timestamp feature by setting
> XDP_TXMD_FLAGS_TIMESTAMP flag.
> You can refer to tools/testing/selftests/bpf/xdp_hw_metadata.c
> on how to do it.=20

Got it. Thanks!

>=20
> > >=20
> > > If so, we now have a feedback channel for meta information for/from T=
X.
> > > Are there any plans - or would it be possible - to support Earliest
> > > TxTime First (NET_SCHED_ETF) QDisc based on that channel? In the past
> > > we had the problem that we we're missing a feedback channel to
> > > communicate back invalid lunch times.
> >=20
> > Just asking: How would that work? AFAIK XDP bypasses the Qdisc
> > layer. Currently invalid Launch Times are accounted in the ETF Qdisc
> > itself. Does that mean every driver has to take care of it?
> >=20
> > Thanks,
> > Kurt
>=20
> Florian & Kurt,
>=20
> Yes, me and Stanislav are trying to add Earliest TxTime First / Launch Ti=
me to the framework.
> Please refer to [1] for the patchset. The metadata framework will just pa=
ss the
> Launch time value to driver, and driver need to handle the rest.
> In the patchset, I am enabling it on stmmac driver only, but we need more=
 drivers
> to check whether the design is feasible for different drivers, cause each=
 driver is
> having their own limitation on launch time. Therefore, after this tx hwts=
 patch accepted,
> I will try to enable launch time on igc driver, and submit new version.=
=20

Nice to hear! Keep me in the loop and let me know if I could support
somehow.

>=20
> Kurt is right that current metadata framework is lacking a way to feedbac=
k whether
> the launch time is invalid or not. Maybe we can try to enable launch time=
 without feedback,
> then discuss about the status report design.

In case the launch time is invalid - couldn't we simply skip the frame
and "forward" it back to the application (completion queue/ring) after
adjusting some meta-information (like the TX timestamps in this patch)
telling the application what happened?

Thanks a lot!
Florian

>=20
> [1] https://patchwork.kernel.org/project/netdevbpf/cover/20231203165129.1=
740512-1-yoong.siang.song@intel.com/
>=20
> Thanks & Regards
> Siang


