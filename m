Return-Path: <linux-kernel+bounces-63945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F08E08536A1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655E41F24CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C78C5F856;
	Tue, 13 Feb 2024 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GeNdte29"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F822C695;
	Tue, 13 Feb 2024 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843273; cv=none; b=Iqw6KFWeL6iGM5Zmoab8ZDNwVuS50nFvItYviiTxQhWjCSmx8ig8Y0SaKlaABCNyft6B7gpxLQ8JLaZyq7I4l32mpChqwoKW6GuhveSQ5U7YoEDvgsPHyze6u3Qreri6tFCJLTSx1bVZoftTjIH5ez+uptW0idlzT/WwJRYJirQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843273; c=relaxed/simple;
	bh=xEg5ouqnb/N8+KsSAGFLMCMLgtEyusBJnWDJ1mOZXKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOkUMwhhiPVCAu37l3hdBvnP2qOp8kGVwzJ44U8arxdxO6r12zRU7el2/JWvKLOwH8r4zqDRvBz3x29yURF7q0lw6ESSXSxNdGgB6Wg4SaaE5IxqTlGkRDjiKIMHFWEBYJ9MRHGSFiG0q3AfB1D8hFCOSYmG+R86zYNbaZU8aX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GeNdte29; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707843272; x=1739379272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xEg5ouqnb/N8+KsSAGFLMCMLgtEyusBJnWDJ1mOZXKI=;
  b=GeNdte29/hUfMpkDXtAbBziJ7DbfSAhqLP8VqMb8nDEFi2vNzX9BipXz
   mpmnvqIgdNf3MYvzO976xS74Ih1KlZnrmf8Pp+Sh5pugzhkL2ixsnIMfx
   NRHiOiDgMGiFnrvDDHGB1PolRsM6LknElHG7ePgqWabrMzd/Xn03yrN33
   cmzAIPATzMeRhj76HYukoXJelgEbXo8+mB7GkWjWa3Fnj9T+NcA3cisNd
   isHAn3gFGfw3cYCBlv8U+j7IftK4bcHwOxL5yulYREmgs7T8a5EeoZsVM
   UyQZPEQjrzFBz+IAVJrl7pfgA3oOD4hDm5kNAklFz7MiZaNo42XtDd6OL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="5633847"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="5633847"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 08:54:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="2911660"
Received: from mhakkine-mobl4.ger.corp.intel.com (HELO himmelriiki) ([10.251.219.175])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 08:54:27 -0800
Date: Tue, 13 Feb 2024 18:54:16 +0200
From: Mikko Ylinen <mikko.ylinen@linux.intel.com>
To: "Xing, Cedric" <cedric.xing@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Dan Middleton <dan.middleton@linux.intel.com>,
	Samuel Ortiz <sameo@rivosinc.com>, Qinkun Bao <qinkun@google.com>,
	"Yao, Jiewen" <jiewen.yao@intel.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>, biao.lu@intel.com,
	linux-coco@lists.linux.dev, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
Message-ID: <ZcueuCGgq-l9U4Er@himmelriiki>
References: <1557f98a-3d52-4a02-992b-4401c7c85dd7@linux.intel.com>
 <85b7a4a679eada1d17b311bf004c2d9e18ab5cd3.camel@HansenPartnership.com>
 <b8140cc8-a56b-40f6-a593-7be49db14c77@intel.com>
 <fe1722c3618a8216cb53b8fd3f1b7cbb6fdff5a0.camel@HansenPartnership.com>
 <65c2e4aa54a0_d4122947f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <22088ed3-51a4-415f-932c-db84c92a2812@intel.com>
 <527da630-4952-4b1d-80c0-5a87997ff9fd@linux.intel.com>
 <332775d7218843d6cc168c963d76e6841eab5d5b.camel@HansenPartnership.com>
 <65c691e13a50d_afa42948a@dwillia2-xfh.jf.intel.com.notmuch>
 <226df539-b3f4-4099-b6a6-293fa200c536@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <226df539-b3f4-4099-b6a6-293fa200c536@intel.com>

On Mon, Feb 12, 2024 at 11:36:27PM -0800, Xing, Cedric wrote:
> On 2/9/2024 12:58 PM, Dan Williams wrote:
> > James Bottomley wrote:
> > > Just to correct this: IMA uses its own log format, but I think this was
> > > a mistake long ago and the new log should use TCG2 format so all the
> > > tools know how to parse it.
> > 
> > Is this a chance to nudge IMA towards a standard log format? In other
> > words, one of the goals alongside userspace consumers of the RTMR log
> > would be for IMA to support it as well as an alternate in-kernel backend
> > next to TPM. IMA-over-TPM continues with its current format,
> > IMA-over-RTMR internally unifies with the log format that is shared with
> > RTMR-user-ABI.
> > 
> I'm not a TCG expert. As far as I know, https://trustedcomputinggroup.org/wp-content/uploads/TCG-PC-Client-Platform-Firmware-Profile-Version-1.06-Revision-52_pub-1.pdf
> defines the event types for TCG2 logs for firmware uses only. I cannot find
> a spec that defines event types for OS or applications. We may reuse the
> firmware event types for Linux but I doubt they can accommodate IMA.
> 
> IMHO, we don't have to follow TCG2 format because TDX is never TPM, nor are
> any other TEEs that support runtime measurements. The existing TCG2 format
> looks to me somewhat like ASN.1 - well defined but schema is needed to
> decode. In contrast, JSON is a lot more popular than ASN.1 nowadays because
> it's human readable and doesn't require a schema. I just wonder if we should
> introduce a text based log format. We could make the log a text file, in
> which each line is an event record and the digest of the line is extended to
> the specified runtime measurement register. The content of each line could
> be free-form at the ABI level, but we can still recommend a convention for
> applications - e.g., the first word/column must be an URL for readers to
> find out the format/syntax of the rest of the line. Thoughts?

There's also the 'Canonical Event Log' format from TCG. It
covers IMA but it looks it's PC/client specific otherwise.

systemd seems to be following this format for its systemd-pcr*
services and exposing the log in JSON format under /run/log [1].

[1] https://www.freedesktop.org/software/systemd/man/latest/systemd-pcrphase.service.html

> 
> > ...but be warned the above is a comment from someone who knows nothing
> > about IMA internals, just reacting to the comment.
> > 
> > 
> > > > I am wondering where will the event log be stored? Is it in the
> > > > log_area region of CCEL table?
> > > 
> > > IMA stores its log in kernel memory and makes it visible in securityfs
> > > (in the smae place as the measured boot log).  Since this interface is
> > > using configfs, that's where I'd make the log visible.
> > > 
> > > Just to add a note about how UEFI works: the measured boot log is
> > > effectively copied into kernel memory because the UEFI memory it once
> > > occupied is freed after exit boot services, so no UEFI interface will
> > > suffice for the log location.
> > > 
> > > I'd make the file exporting it root owned but probably readable by only
> > > the people who can also extend it (presumably enforced by group?).
> > 
> > I assume EFI copying into kernel memory is ok because that log has a
> > limited number of entries. If this RTMR log gets large I assume it needs
> > some way cull entries that have been moved to storage. Maybe this is a
> > problem IMA has already solved.
> 
> We don't have to, and are also not supposed to I guess, append to the log
> generated by BIOS. The kernel can start a new log, and potentially in a
> different format. I think the BIOS log is exposed via securityfs today. Am I
> correct? For the new TEE measurement log, I don't think it has to be
> collocated with the BIOS log, because TEEs are never TPMs.

-- 
Regards, Mikko

