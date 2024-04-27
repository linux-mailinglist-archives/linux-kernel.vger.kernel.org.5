Return-Path: <linux-kernel+bounces-160926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E278B449C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 08:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3EA8283FF8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 06:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736B34438F;
	Sat, 27 Apr 2024 06:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="inu+aX/8"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1190D4175A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 06:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714200228; cv=none; b=KtECjmSzQX+wC+NJQ+H90xhkuIqY36aYiZZJzP6cJA6nuXKjqJweqD2t+bqjMPvTupn97icYUlH54o78bI3XJOPquwZ+/hTbgEVl7pQMGhav+d4tjMF/HOXPdS0iO0vVLzh/JUO+KleKHiOb5Q6kNM0X6R5tv7oOCeRImPHkPgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714200228; c=relaxed/simple;
	bh=VkyLb1CWK7GD6oOW4LIgr2TD1bfVjslAh6DpSQaljpo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lDRfyZI01HzDRJ4UrjoxIKMbhnc/bL8GiFWQXRrkaVjqNmEAJrmh8Ij/flHlf0qopOnZ6p3QjAwUr2zR+bRWMkogZAvsymwKLezJiRnA+8u4fDOTf+m1iM7OTYKe5Cr27VkTQty65cHHhY46INqL3FesKfk6z/3V6HtwUuhaRF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=inu+aX/8; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1714200166; x=1714804966; i=efault@gmx.de;
	bh=rLvz8stMPrmSzBgKA/+sU2ehx3aXsDikmL+4nnpWMfU=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=inu+aX/8Gx10cKGXYMCtdrMQ2G3rtppZe7XDqBWSDzuNBIioY2bhL4XLjFBCOhGt
	 fviwf8fU35+1gan9YIH3XCTmawegV9IAGEgFGKFNU6dK4NOv5tso/3n8BujGniJX7
	 D+HB+dHuZAZFhL5QsbUKMm8LGeXTun9EmhXoD6yLxxlhkLctuBmwdFq6FIYk9eDsl
	 B4kNuS1KV+YgAY3/ZscYKqNZd1g4ktcOZ6xx6s/meU8CBKEN7q+ve7p04oQmoJzII
	 kt6sIzWQP/Azkfm8UbXIfoa4eTvDAl3geSr72rxs2/DNzSO9HiNMWGqfd0269Veyd
	 /24+tpGyuCjSvUf3+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.49.222]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmfi-1s7qkJ36h0-00Tima; Sat, 27
 Apr 2024 08:42:45 +0200
Message-ID: <8d2fd91db108428680cd4ed988b36cf3f579c5ec.camel@gmx.de>
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, mingo@redhat.com, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,  rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com,  vschneid@redhat.com,
 linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com, 
 tglx@linutronix.de, Chen Yu <yu.c.chen@intel.com>, Oliver Sang
 <oliver.sang@intel.com>
Date: Sat, 27 Apr 2024 08:42:42 +0200
In-Reply-To: <18f557cd69fc65f5b43daddd8ad3e43278dfa44e.camel@gmx.de>
References: <20240405102754.435410987@infradead.org>
	 <20240405110010.631664251@infradead.org>
	 <557be85d-e1c1-0835-eebd-f76e32456179@amd.com>
	 <ec6f811b9977eeef1b3f1b3fb951fda066fd95f5.camel@gmx.de>
	 <14330cf4-8d9e-1e55-7717-653b800e5cee@amd.com>
	 <747627a1414f1f33d0c237f555494149d6937800.camel@gmx.de>
	 <2b9f7617f2b2130bb6270504ec3858f15d463f1d.camel@gmx.de>
	 <20240425112855.GF21980@noisy.programming.kicks-ass.net>
	 <20240426105607.GK12673@noisy.programming.kicks-ass.net>
	 <20240426111607.GL12673@noisy.programming.kicks-ass.net>
	 <18f557cd69fc65f5b43daddd8ad3e43278dfa44e.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DoKqMFH4lF8ZnGX2avQuOTNxFxNBU/ICIOtx+ChTIsEsAJ7cLwd
 cJFiWEAuWPl8idDcZ2VG9jY7udD+PhjGe19TOKeLWXep4473txN8tVjo1mHe3EyxTTZk3nh
 +Bh5mHiwSk7FXivkYDAEG+JV3VWnxWE8K/m7Yl+R12bmCcAb131HOQoxtzDYY++u0z5bB4R
 0Y0k7a4c6MzH2BEsssKYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XlzO2TdpUVE=;fLIcnmNX4eWgYMOQtMMeE1sxNLA
 YW0jz4/qVnsf+4ZAGvTIpn+xV4jO+/pWhKkp7WkV2cdzYvU7u8LoChNS2M/t6iuxYtlxAuNW/
 h0b2BUIxCq+kREh/C8JoXUwwaLoD+3Aq/dJVncpawObAFTfpdzippzUPIUar8eachTYkF2lp/
 rnp6II/CT1D+1BiqFvG9Hcj2MArqqXcm/MUJZZE0M0FtSJ1Cr5UCcKrrhpHw1atj013hXTHk5
 M9LEYu4KetQhVO52iZIXsHJmgzPk/H3dcc2+qNfCJUn/GDuC4D1OYnNGotJnkrFe5RPaMwMdY
 S+aqxUsE3d5YpWnvSphte79HCAEino3EAsX4vFDierz7CyEcKjg0GxEGUWFUfzhsiPSQxiN/s
 cMI6+PRhaRNz/Txf76J4iqvEPyVSuMxopcV2XkOxs2CZVqFeAvSCnol5D6QZrji3Cd6YF9Gkq
 +BPnAdttndKgulUhxDGINmXD12gre6FE5R+ZlM9tjuA0qOC07cZiY+PWAb5tJ2cOejhjKH5bS
 fegOTtHwD9+zWUuYruuMAbA4mYTIbpMWt3I+rCkP7lftuGsITX1yLNFkWlKPCDkRNGlIBM6s4
 56mlvkw65bGEOtMIpyY+I079i7vXgfKz/QDX6lKJAUvttm+octBbZJ/mFY8KNmja2pPa9AvJK
 hoLzKUN2LMk9qQrUmCw490ssczGZkMOdLFI5EwNjk1tSSR9dAX+0N8dXNJarU5khnAE2cZra0
 yHqwUm9nylqwAAj9+TPsu/kJ1Uas0624uZIw85WpU3KdbUPAMX1nQOL+7JjKBRSD5iXV14OaY
 VJnlZOwj7JN9B8oELkBfOpFhhjtlu0WwsfAewLHPFNPxQ=

On Fri, 2024-04-26 at 18:03 +0200, Mike Galbraith wrote:
> fwiw, tbench liked the previous version better.

The culprit lies somewhere in the new PREEMPT_SHORT patch.

	-Mike

