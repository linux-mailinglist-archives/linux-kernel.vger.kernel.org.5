Return-Path: <linux-kernel+bounces-25867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C274F82D6F8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70DD1C21778
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15619F9D1;
	Mon, 15 Jan 2024 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GFQxMTU0"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C0AF508
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705313692; x=1736849692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4eF9TG8eAoHdtjzKXauZ8TK9AgTuxnP5KpYNNgJGSqs=;
  b=GFQxMTU0vFyi3OAQ2UJkS9TTYXRA62J2Kzw6inyfdnjvX5Dpm3hg/Do+
   qk/ZnGtyqQ+ZvqcyyTw38bhywtSwTqZ26NWs2sGp7tSO1tAcA8uMqWot8
   YCY430Xy21CdOvHcLoNPFzavqT4nu9cXt828tYysgPnif73p4D50uMrDS
   J6xj5+i8ylj6WTBaauK8Lkz4eC8dZ2WP/nV1soaH8DTSQGZ6tNNrdnlwE
   Ln6W207spl4VNJve4Cwsj7ZJvUrLzQ7pekHJxFku5aacp2RJYsri/+XwJ
   rehOx9tUZY2RnrN3rSsd8VIFOLeZap9P4vX6EqNwAl4Fv/IMeAkwocH6K
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="485744803"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="485744803"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 02:14:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="783774174"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="783774174"
Received: from jeroenke-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.55.160])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 02:14:46 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id AB3C410A58F; Mon, 15 Jan 2024 13:14:43 +0300 (+03)
Date: Mon, 15 Jan 2024 13:14:43 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: NOMURA =?utf-8?B?SlVOSUNISSjph47mnZHjgIDmt7PkuIAp?= <junichi.nomura@nec.com>
Cc: "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"david@redhat.com" <david@redhat.com>,
	"nikunj@amd.com" <nikunj@amd.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"debarbos@redhat.com" <debarbos@redhat.com>,
	"jlelli@redhat.com" <jlelli@redhat.com>,
	"lgoncalv@redhat.com" <lgoncalv@redhat.com>,
	"dzickus@redhat.com" <dzickus@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Add a message about ignored early NMIs
Message-ID: <20240115101443.yrt7abegw2m6fxlt@box.shutemov.name>
References: <ZaEe8FC767f+sxRQ@jeru.linux.bs1.fc.nec.co.jp>
 <20240112120616.5zjojjmjeqg5egb7@box>
 <ZaTziftQSSg/v5Np@jeru.linux.bs1.fc.nec.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZaTziftQSSg/v5Np@jeru.linux.bs1.fc.nec.co.jp>

On Mon, Jan 15, 2024 at 08:57:45AM +0000, NOMURA JUNICHI(野村 淳一) wrote:
> Commit 78a509fba9c9 ("x86/boot: Ignore NMIs during very early boot") added
> empty handler in early boot stage to avoid boot failure by spurious NMIs.
> 
> Add a diagnostic message in case we need to know whether early NMIs have
> occurred and/or what happened to them.
> 
> Signed-off-by: Jun'ichi Nomura <junichi.nomura@nec.com>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Suggested-by: H. Peter Anvin <hpa@zytor.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

