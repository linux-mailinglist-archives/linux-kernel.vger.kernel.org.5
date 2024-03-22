Return-Path: <linux-kernel+bounces-111410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE8F886BEB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62464B228D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D51D3FE4B;
	Fri, 22 Mar 2024 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="kkHOLx4B"
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A727171C1;
	Fri, 22 Mar 2024 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711109757; cv=none; b=X4K3DK/xN1ZxXfzavrWX0DrlWLLNGtaLhnE5SEiHOv3hF/JS3nn5te3mIWu1HaxBvQGUduNFHNciR6a2phLR7Ul9BTn/UmK/MAYqnlSZgrDOJJdQFL3v37cNv9C0Wm0vEYG2T5vxCCiIjS0Dm2dnfm1r8BDM5q/05GKBk4c2wMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711109757; c=relaxed/simple;
	bh=JWlzNTdBPfHAxnqkWziniLXSJYrdVDBFRm2ImvbfiSc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=QGYzJW/eckdZfrNWiZpOEvmNdIH861cyuvHEVJPnTyNr7JBWM6vxinv81vPg/s7LsvAR6mjbtCmEIYerU+0JHmNfojbLXnn+RtL/jvhhCjt+UmZ1xYZ+72P+GowrxKcACKSt85o4X+J6C09PLHWo9EV+21KgMd2iZZunz049AUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=kkHOLx4B; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10da:6900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 42MC0OpO490219
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 12:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1711108824; bh=v1Mw2t0DHAqma4CLFbfsRIpr8UUgEMDDKtBpdTfFWZo=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=kkHOLx4BY4hrINWm3v7suVdWXoyKOo9sC95WCxewPn7sSlV7Lq/GGm9SGPg3uiBu6
	 0nNN2clcjmde6NDBXGWgN15PezfcHA8pRYU6YjCp3/aGAwS6dK28zDcMkHrzxtmheO
	 5wldMRSxgX0W4n+7aPuuNQ47As7rQfhSMrfuheVM=
Received: from miraculix.mork.no ([IPv6:2a01:799:10da:690a:d43d:737:5289:b66f])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.17.1.9/8.17.1.9) with ESMTPSA id 42MC0N8w3345610
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 13:00:23 +0100
Received: (nullmailer pid 1671577 invoked by uid 1000);
	Fri, 22 Mar 2024 12:00:22 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Liviu Dudau <liviu@dudau.co.uk>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
        Haijun Liu <haijun.liu@mediatek.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
        M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: net: wwan: t7xx: BUG: Unaligned access when loading mtk_t7xx
 module
Organization: m
References: <Zfxlj3pYUk4ys47T@bart.dudau.co.uk>
Date: Fri, 22 Mar 2024 13:00:22 +0100
In-Reply-To: <Zfxlj3pYUk4ys47T@bart.dudau.co.uk> (Liviu Dudau's message of
	"Thu, 21 Mar 2024 16:51:27 +0000")
Message-ID: <87il1ezdbd.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.0.3 at canardo
X-Virus-Status: Clean

Liviu Dudau <liviu@dudau.co.uk> writes:

>  I had a
> go at guessing that UL registers are at 0x8 and 0x48 offsets and DL
> registers are at 0x0478 and 0x04b8, but while that fixes the alignment
> exception, I now get a "CLDMA{0,1} queue 0 is not empty" message.

I don't think you can assume the register offsets are wrong.  It looks
more like the device doesn't care about alignment.

But given that the driver includes <linux/io-64-nonatomic-lo-hi.h>, you
can probably replace those unaligned 64bit accesses with two nonatomic
32bit accesses.


Bj=C3=B8rn

