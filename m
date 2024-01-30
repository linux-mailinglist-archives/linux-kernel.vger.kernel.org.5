Return-Path: <linux-kernel+bounces-43922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA2D841AC6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBDBE28750C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F7C374FE;
	Tue, 30 Jan 2024 03:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCEjmiRY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8D9374F8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706587100; cv=none; b=bc8wRBchulSelDJmEjFsS+TtYuafsNi8JOG+1zSPV3NqNsMs9j3nGgNM1lnYUSykH3q/9H0Mn3F4Qwvb4dhcXPKGH6ulZORkqarhf+7g5Egp38ohphFMqO/nWfG6G19xT2vItgkCDD6b+A9FhDHLoj1YYr/hriUmOO3d35++gas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706587100; c=relaxed/simple;
	bh=hY2Kcvcx/I55SmbSpelpIm3429x8ezwdUMiRnAOWyL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSVkASenhfjMnVjamMLqxG1B/+eEnpLGZyTPEidqDmIfrRHdMjzT2nS4SKA6aXB1ASANdtlN8N44g8Vsre5ugjzf9M//FsQFnt2idnZeITEqZqpYs3yX0mQl6bg5tcwkZBmrvU6OBKXpWGkLzmpedgg+JtnplxK9UBSQF/sYXd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OCEjmiRY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706587097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u8RDoe2yCdgr10/YRzYCMiM1TZtxb1vkYMgwLoeeQrg=;
	b=OCEjmiRYD3cxwHpv6u3Qfsgvqh/m5qFSLtE6Thc6U2CwabqCeWZvuSwCE3VjyKrQz34pGt
	kdSjtBuJ0pidin83ToHDYluggRrTl3EqKZ6BKY9waut7GQiH32efV3E63tDWdTp4eMMbxc
	sREFKvpcCNG9w6unTGwkNQ4MHqgT09Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-blDvJ29cOj2GDaPpPG2lBA-1; Mon, 29 Jan 2024 22:58:13 -0500
X-MC-Unique: blDvJ29cOj2GDaPpPG2lBA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AF1983B82B;
	Tue, 30 Jan 2024 03:58:12 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A8BAAC0FDCA;
	Tue, 30 Jan 2024 03:58:11 +0000 (UTC)
Date: Tue, 30 Jan 2024 11:58:08 +0800
From: Baoquan He <bhe@redhat.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"nathan@kernel.org" <nathan@kernel.org>
Subject: Re: [PATCH linux-next 1/3] x86, crash: don't nest CONFIG_CRASH_DUMP
 ifdef inside CONFIG_KEXEC_CODE ifdef scope
Message-ID: <Zbhz0D3DgDyTsboe@MiWiFi-R3L-srv>
References: <20240129135033.157195-1-bhe@redhat.com>
 <SN6PR02MB41571397201804BD486C6148D47E2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ZbhH+sg1BPi+R0j4@MiWiFi-R3L-srv>
 <SN6PR02MB41575A5568875B85C8AA7F4BD47D2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41575A5568875B85C8AA7F4BD47D2@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 01/30/24 at 01:39am, Michael Kelley wrote:
> From: Baoquan He <bhe@redhat.com>
> > 
> > On 01/29/24 at 06:27pm, Michael Kelley wrote:
> > > From: Baoquan He <bhe@redhat.com> Sent: Monday, January 29, 2024
> > 5:51 AM
> > > >
> > > > Michael pointed out that the #ifdef CONFIG_CRASH_DUMP is nested inside
> > > > arch/x86/xen/enlighten_hvm.c.
> > >
> > > Did some words get left out in the above sentence?  It mentions the Xen
> > > case, but not the Hyper-V case.  I'm not sure what you intended.
> > 
> > Thanks a lot for your careful reviewing.
> > 
> > Yeah, I tried to list all affected file names, seems my vim editor threw
> > away some words. And I forgot mentioning the change in reboot.c.
> > 
> > I adjusted log as below according to your comments, do you think it's OK
> > now?
> 
> Yes -- looks like everything is included and clear up my confusion.  But
> I still have two small nits per below. :-)

Right, I will grabbed them into v2. Thanks again.

> 
> > 
> > ===
> > Michael pointed out that the #ifdef CONFIG_CRASH_DUMP is nested inside
> > CONFIG_KEXEC_CODE ifdef scope in some XEN, HyperV codes.
> 
> s/Hyper-V/HyperV/
> 
> > 
> > Although the nesting works well too since CONFIG_CRASH_DUMP has
> > dependency on CONFIG_KEXEC_CORE, it may cause confusion because there
> > are places where it's not nested, and people may think it needs be nested
> 
> s/needs to be/needs be/
> 
> > even though it doesn't have to.
> > 
> > Fix that by moving  CONFIG_CRASH_DUMP ifdeffery of codes out of
> > CONFIG_KEXEC_CODE ifdeffery scope.
> > 
> > And also put function machine_crash_shutdown() definition inside
> > CONFIG_CRASH_DUMP ifdef scope instead of CONFIG_KEXEC_CORE ifdef.
> > 
> > And also fix a building error Nathan reported as below by replacing
> > CONFIG_KEXEC_CORE ifdef with CONFIG_VMCORE_INFO ifdef.
> > ......
> > ===
> > 
> > Thanks
> > Baoquan
> 


