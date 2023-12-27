Return-Path: <linux-kernel+bounces-12217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E99181F175
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 19:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187841F2308C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061374655B;
	Wed, 27 Dec 2023 18:58:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A81A20306;
	Wed, 27 Dec 2023 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 67a3122417753e74; Wed, 27 Dec 2023 19:58:27 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9C90D668E12;
	Wed, 27 Dec 2023 19:58:26 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Youngmin Nam <youngmin.nam@samsung.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, d7271.choe@samsung.com, janghyuck.kim@samsung.com, hyesoo.yu@samsung.com
Subject: Re: [BUG] mutex deadlock of dpm_resume() in low memory situation
Date: Wed, 27 Dec 2023 19:58:26 +0100
Message-ID: <5755916.DvuYhMxLoT@kreacher>
In-Reply-To: <5754861.DvuYhMxLoT@kreacher>
References: <CGME20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4@epcas2p3.samsung.com> <2023122701-mortify-deed-4e66@gregkh> <5754861.DvuYhMxLoT@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvddvledguddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedutddprhgtphhtthhopeihohhunhhgmhhinhdrnhgrmhesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvnhdrsghrohifnhesihhnthgvlhdrtghomhdprhgtphhtthhopehprghvvghlsehutgifrdgt
 iidprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

On Wednesday, December 27, 2023 7:39:20 PM CET Rafael J. Wysocki wrote:
> On Wednesday, December 27, 2023 5:08:40 PM CET Greg KH wrote:
> > On Wed, Dec 27, 2023 at 05:42:50PM +0900, Youngmin Nam wrote:
> > > Could you look into this issue ?
> > 
> > Can you submit a patch that resolves the issue for you, as you have a
> > way to actually test this out?  That would be the quickest way to get it
> > resolved, and to help confirm that this is even an issue at all.
> 
> Something like the appended patch should be sufficient to address this AFAICS.
> 
> I haven't tested it yet (will do so shortly), so all of the usual disclaimers
> apply.
> 
> I think that it can be split into 2 patches, but for easier testing here
> it goes in one piece.

Well, please scratch this, it will not handle "async" devices properly.




