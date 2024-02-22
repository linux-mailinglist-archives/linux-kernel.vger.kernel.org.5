Return-Path: <linux-kernel+bounces-75998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA1D85F1C0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17721F21750
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46BD1775B;
	Thu, 22 Feb 2024 07:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQWpuxce"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9532D17583
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708585638; cv=none; b=PN9D0hS7iQCI7/oUyZfSVbFrva6iDTZwnn8AyD2xG+qTS171iim0rzjH4u4UZsLgUfk2JexuahJFOr7rf9d+l8x5AU1DngISFyMvc6tRlJG4RFpKlhcTNSLX+3a7Bvg1vc/7HBr9Qgj5u3o8FJaXqWP5TxdwvMD+p1ZJ+hSHhPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708585638; c=relaxed/simple;
	bh=XPKVLBy6UQC9Sn82UWX+PNOQ0fEBJPFiiwTcFZ/REG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHJaoiUjOYsroj8ekKv47wKZ8WQnEKxbZvE/LuqZsf1L992ImaaTXcrOk+uERYSgwhKoF4l4jcLjH8yI6J8fpAPYqJBdN49KiXhFopVKmjk0KwU0U45wq5IDkxOpDG7+ERyjqna3wMpsosa3hJDKVojg5lgAnrAcbKNejQ1eZy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fQWpuxce; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708585635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j88KzvyAQZThT6aCL8ZS+o2FWYKBFq83FjUT4vcsoNg=;
	b=fQWpuxce//4uZGr5U1PE3xBVtJWJN9xvv81sG9m70FLGad0Y12Fgio5BCkuxDgjVoEnxq2
	ToSfroJJdzBWiu52cHddImf1qf206Jihjy+c2Nwrn0N3RuNKyiYHQKfI1I7P3B4caw2MFw
	In7mU9mVI2otn5GmPDsPo2NxztTWMN4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-MaV-uow3NFqRm-_MOPABCw-1; Thu, 22 Feb 2024 02:07:12 -0500
X-MC-Unique: MaV-uow3NFqRm-_MOPABCw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B19A185A787;
	Thu, 22 Feb 2024 07:07:11 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A8B5A492BC8;
	Thu, 22 Feb 2024 07:07:08 +0000 (UTC)
Date: Thu, 22 Feb 2024 15:07:05 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>, linux-s390@vger.kernel.org,
	piliu@redhat.com, linux-sh@vger.kernel.org, x86@kernel.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org, ebiederm@xmission.com,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 00/14] Split crash out from kexec and clean up related
 config items
Message-ID: <Zdbymex3ABImSwI3@MiWiFi-R3L-srv>
References: <20240119145241.769622-1-bhe@redhat.com>
 <9101bb07-70f1-476c-bec9-ec67e9899744@linux.ibm.com>
 <Zb8D1ASrgX0qVm9z@MiWiFi-R3L-srv>
 <559f2595-1477-4ef0-80e4-85ae8b426de7@linux.ibm.com>
 <20240221125752.36fbfe9c307496313198b60f@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221125752.36fbfe9c307496313198b60f@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 02/21/24 at 12:57pm, Andrew Morton wrote:
> On Wed, 21 Feb 2024 11:15:00 +0530 Hari Bathini <hbathini@linux.ibm.com> wrote:
> 
> > On 04/02/24 8:56 am, Baoquan He wrote:
> > >>> Hope Hari and Pingfan can help have a look, see if
> > >>> it's doable. Now, I make it either have both kexec and crash enabled, or
> > >>> disable both of them altogether.
> > >>
> > >> Sure. I will take a closer look...
> > > Thanks a lot. Please feel free to post patches to make that, or I can do
> > > it with your support or suggestion.
> > 
> > Tested your changes and on top of these changes, came up with the below
> > changes to get it working for powerpc:
> > 
> >  
> > https://lore.kernel.org/all/20240213113150.1148276-1-hbathini@linux.ibm.com/
> 
> So can we take it that you're OK with Baoquan's series as-is?
> 
> Baoquan, do you believe the patches in mm-unstable are ready for moving
> into mm-stable in preparation for an upstream merge?

Yeah, I think they are ready to go for merging.

For Hari's patchset, the main part was planned before. And I am not
familiar with fadump in powerpc, the Kconfig fix from Hari is a good
guarantee with the expertise. Surely, I will await Hari's comment on
that.


