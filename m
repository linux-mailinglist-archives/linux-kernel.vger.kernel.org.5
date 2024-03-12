Return-Path: <linux-kernel+bounces-100757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F567879CC9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914431C213DD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983E314290D;
	Tue, 12 Mar 2024 20:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JMWslwId"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28B81386AA;
	Tue, 12 Mar 2024 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710274954; cv=none; b=Wa3wAx+rb1AZwDe3ZYIkV43fJzLp+qdM+hCzf/L8WC8uyAHR03lnYcKug09wyYuguzrspj/kwkaQW6MHHADI8r97vAuC0CqCVcpmsVCpoNeJFdv2SNZd/THmfK0VTf/kkLhg70/21IUNGz7noLVFwrmuvYxJd37J18XKZ4wtmeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710274954; c=relaxed/simple;
	bh=Pr5lhOrEPrMJqPAwR3vdY7dlJDIhGLkhSYZOK85QpNs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=X6NvG3cIV51+0VhsEdT3msPJwV5IYj/BBzz4g126hd3fUaBKdH00OhJPJ7HMLFaH2ti5S4O/lUH6Ekbd7Dh5aIzqwHT2EVDt/TRdbU0IvfDrMA+haiKoA2bqPxtn6nXU0c1vkeKY0PsFdNmPXgTKjReqjzvF6589tjQ6DiRBe8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JMWslwId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5D0C433C7;
	Tue, 12 Mar 2024 20:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1710274954;
	bh=Pr5lhOrEPrMJqPAwR3vdY7dlJDIhGLkhSYZOK85QpNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JMWslwIdP4OWf5ct0J5wlCAlOEXwLAlFAYm+rpdZuRElOApbGIZ0KcNkJ2S3qG6b+
	 fGQkSlgljL2lZyAwVOiEzbdcv+3noDCbQtArckxN/voeH/K5KOFFGLOeQ5eYCbj4c8
	 aWDQufFjOWDNbpL/L7XxWZsj5Mii5d0ZR+29Dm4E=
Date: Tue, 12 Mar 2024 13:22:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>, "Jiang, Dave"
 <dave.jiang@intel.com>, "osalvador@suse.de" <osalvador@suse.de>,
 "david@redhat.com" <david@redhat.com>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "Huang, Ying" <ying.huang@intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "willy@infradead.org"
 <willy@infradead.org>, "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v7 1/5] dax/bus.c: replace driver-core lock usage by a
 local rwsem
Message-Id: <20240312132233.4a04a742c7bae02a31eed78f@linux-foundation.org>
In-Reply-To: <ebc79448a1fdb47ff16144c12cd5d8dfc733dee8.camel@intel.com>
References: <20240124-vv-dax_abi-v7-0-20d16cb8d23d@intel.com>
	<20240124-vv-dax_abi-v7-1-20d16cb8d23d@intel.com>
	<65f0b5ef41817_aa222941a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<ebc79448a1fdb47ff16144c12cd5d8dfc733dee8.camel@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 20:20:17 +0000 "Verma, Vishal L" <vishal.l.verma@intel.com> wrote:

> > All of these WARN_ON_ONCE() usages should be replaced with
> > lockdep_assert_held() and lockdep_assert_held_write() where appropriate.
> 
> Makes sense - I can send a patch post -rc1 to change these if that's okay Andrew?

Please do.

