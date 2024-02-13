Return-Path: <linux-kernel+bounces-62853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF138526DD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1911F259BF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD7A7AE66;
	Tue, 13 Feb 2024 01:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jk61vhMv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5131428DB7;
	Tue, 13 Feb 2024 01:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786424; cv=none; b=BLVxx/QzblCrBIU3iv3sw0cMdxmCj4wlpXF0oMjb9li8wgqOaBkT1AnOI/DI1MiFuxQfO0cL1QAGhg+w7ipwHNkU7kjJfzw6LNN+OMSTuV8tflxemeB+0NzDnn8EP2h5zrz44oCk5G0u9fHhtKKAtO8VpzgIusVRZztG3bTYa2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786424; c=relaxed/simple;
	bh=peoO574K4wfwc8JzNW3ZPwHb5yzWC0yTYMUNPjNzFMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tu2zv0L6VDaPjZ9wsjb5WmAhzknAskgyCUxuxjpw5cNkjBpgWAJOzFt2pfja/rHVHQ58VVg+CX3FW6gjb6XXgtWvJ3n4Rz9xOVSv6v+YH+LFKfdBm2433+ps9pWBN8R5mB2f8YAvrBsKUnmLiaQ47UKY9kx+3zwBvvZ/5WI1SbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jk61vhMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6431C43390;
	Tue, 13 Feb 2024 01:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707786423;
	bh=peoO574K4wfwc8JzNW3ZPwHb5yzWC0yTYMUNPjNzFMk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jk61vhMv0DpQERHjsyFWEND7ONl8w1aGspJ5NqBje076fszXvrnzoPAuiqTnAcEai
	 YzmqtNKBXKGGUFX03135Pb5OjN0AU+IuiZs5ZMLvwm62PnkFBipnYXhfu2416GlpW4
	 qh6sNYFvrDfXNAR28Ec4uIY1Z+P0/KI1Zr9zb3ls6arDTJlxcSqeaOGIVNfpqnnXsP
	 KA+4BvC3a1S8ZRDFa5gvikE1rd1N03O4iR1kKVbqD8IprCnFhtVuEfljDKWFNqMBUA
	 iwQAuf/S6WxTOLFyEEA+NNYOVSZbMYMZFDfdtMBTi0yMpZmZ3Ubu/emiFFDD8PB110
	 2qsCEvfDnoE4g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 575BCCE0C4C; Mon, 12 Feb 2024 17:07:03 -0800 (PST)
Date: Mon, 12 Feb 2024 17:07:03 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Luck, Tony" <tony.luck@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Naik, Avadhut" <avadnaik@amd.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Message-ID: <c72b9c44-1908-4934-a890-3a3e9a39ef9d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <b5904910-ed58-405f-9425-566383b48068@amd.com>
 <SJ1PR11MB6083CF3400AD2F2047D65E17FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <34b19db5-bd72-457c-9b6a-c2089f6be83c@amd.com>
 <SJ1PR11MB6083E7E11F6C7BCC8C6C7F21FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212201038.GNZcp7PuIqIJndpDM9@fat_crate.local>
 <47901422-ac07-47db-bf44-3f4353e92b1d@paulmck-laptop>
 <20240212212741.GPZcqNTXfU2OX7uRtx@fat_crate.local>
 <2d8b17f2-c22f-478f-b407-9d2dfd2064f7@paulmck-laptop>
 <20240212231009.GAZcqlUVY8U2hzOaF4@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212231009.GAZcqlUVY8U2hzOaF4@fat_crate.local>

On Tue, Feb 13, 2024 at 12:10:09AM +0100, Borislav Petkov wrote:
> On Mon, Feb 12, 2024 at 02:46:57PM -0800, Paul E. McKenney wrote:
> > The usual reason is to exclude other CPUs also doing list_add_rcu()
> > on the same list. 
> 
> Doh, it even says so in the comment above list_add_rcu().
> 
> And the traversal which is happening in NMI-like context is fine.
> 
> So phew, I think we should be fine here. Thanks!
> 
> And as it turns out, we're not going to need any of that after all as
> it looks like we can allocate the proper size from the very beginning...

Sounds even better!  ;-)

							Thanx, Paul

