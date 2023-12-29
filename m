Return-Path: <linux-kernel+bounces-13160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC485820087
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CDD284850
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE87812B6A;
	Fri, 29 Dec 2023 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="UeGlzbGQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mr85p00im-ztdg06021201.me.com (mr85p00im-ztdg06021201.me.com [17.58.23.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B563612B60
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1703867622; bh=mdHoqF4DBozjc5AZdCsy35qAGohL7+5V9GIyKGF0W98=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UeGlzbGQ9DI+Z0AI49toYh8BED1yiu6kUd6XzJPfiynDICAgvJY1c65EJ9GhETVxx
	 VXftzlAS/g3gz038LMlo/7PQhIiURZ0P07kLKCSIX/iWuxtJqNNuLoDFKd5KUr3R3c
	 wrPQy7V/8K+3G1OcoRWmPoDNLHcOn9rr3XKWcLdYH1JNJiL71d3o2K21h5AIc2ZgWk
	 DYr7oLAs4m9Jkqzch6NkEEibCD7tag2xrdBTw4zRHTovorWYYlHoDCevD1UOdvFUD9
	 6Q7sadSRKZm6qJLswMQ2pXmci78/w/D/3Cs9yvYftj8qX9s7Pc2VnfWJpc6OugRlak
	 afms62LOfOYSg==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021201.me.com (Postfix) with ESMTPSA id 146253201A3;
	Fri, 29 Dec 2023 16:33:40 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: alexhenrie24@gmail.com
Cc: bagasdotme@gmail.com,
	dan@danm.net,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] net/ipv6/addrconf: Temporary addresses with short lifetimes generating when they shouldn't, causing applications to fail
Date: Fri, 29 Dec 2023 09:33:39 -0700
Message-ID: <20231229163339.2716-1-dan@danm.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <CAMMLpeTCZDakqdkxm+jvQHxbRXhCYd4_PK+VVqMAmZHjSPuPRw@mail.gmail.com>
References: <CAMMLpeTCZDakqdkxm+jvQHxbRXhCYd4_PK+VVqMAmZHjSPuPRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oFRRsbiheUkH9f2_QvM7LSR0PZXkau7h
X-Proofpoint-ORIG-GUID: oFRRsbiheUkH9f2_QvM7LSR0PZXkau7h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-29_06,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030 mlxlogscore=696
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2312290132

I think a maintainer will probably need to make a call here and decide
how to proceed.

> TEMP_PREFERRED_LIFETIME is an administratively set variable: The user
> can change it to whatever they want whenever they want, and the
> operating system can adjust it automatically too.

Agreed. And the behavior it seems you really want is to prevent the
user from administratively setting it to a value that is lower than
REGEN_ADVANCE, so that it won't stop generating new temporary
addresses altogether.

But preventing the user from configuring it to a value that is too low
is different from generating new temporary addresses with preferred
lifetimes that are greater than the currently configured value of
TEMP_PREFERRED_LIFETIME. I still believe it would be better, and would
be in conformance with the RFC, to simply not allow the user to
configure a too-short TEMP_PREFERRED_LIFETIME instead of tinkering
with the lifetimes of generated temporary addresses.

> It's fine to revert the commit for version 6.7 (after all, I think
> everyone wants a break for the holidays). Hopefully by version 6.8 we
> can agree on a way to support users who want to randomize their IPv6
> address as frequently as the network allows.

FWIW, I think the desired effect you are seeking makes sense and is
the right thing to do. I'm just not convinced this is the correct way
to do it. But I'm not a maintainer and also not an expert in IPv6, so
I'm definitely not the right person to make that call.

-- Dan

