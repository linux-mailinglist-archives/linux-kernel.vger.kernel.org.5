Return-Path: <linux-kernel+bounces-37087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC9A83AB5D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA041C2102E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558137A70C;
	Wed, 24 Jan 2024 14:09:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3A477F04;
	Wed, 24 Jan 2024 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105351; cv=none; b=XNAGaeSnd+hEB35uMTQPiQw9D6Q6pDW9ry/8sU3yjsuHNO+FI/ypgCs/Dt8fwlPmyrGhWwfQILgAj6nw4U/uL7S79tZleL92AJ9fxPb2vN/u2yRfQHucG3xP7BjD4yMZOBfF/961vscRD82aQOL9WJ0Zd+4YnLIPXOdijbiS95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105351; c=relaxed/simple;
	bh=9xyQqImeowhTNiBETbyePeJW8OBK843qk/mKs+AU/Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aM5HaTfJ/8nksb5mhJB/sE/d53loRVwm1D/eKgkSbKjBMTuir+kWN4KkzVYJlENono4u1W2MxJ3d2zgY8dEskQY720d42sPbkcYuyvEsXlYvDu5Pkk7hwDSOeirzwzEFvgKlmPh91bitrLOmzbZLk9vAzuC6kQjdoNYGqOTV/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC7FC433C7;
	Wed, 24 Jan 2024 14:09:10 +0000 (UTC)
Date: Wed, 24 Jan 2024 09:09:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Naik, Avadhut" <avadnaik@amd.com>, Tony Luck <tony.luck@intel.com>,
 Avadhut Naik <avadhut.naik@amd.com>, linux-trace-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 yazen.ghannam@amd.com
Subject: Re: [PATCH] tracing: Include PPIN in mce_record tracepoint
Message-ID: <20240124090908.1c4daea8@rorschach.local.home>
In-Reply-To: <20240124095708.GAZbDe9Hks0tL2Aj94@fat_crate.local>
References: <20240123235150.3744089-1-avadhut.naik@amd.com>
	<ZbBV4EGrZw6hJ5IE@agluck-desk3>
	<be870e14-eeb9-4dcf-ba43-a72ef66a3d87@amd.com>
	<20240123203853.66655e95@rorschach.local.home>
	<20240124095708.GAZbDe9Hks0tL2Aj94@fat_crate.local>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 10:57:08 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Jan 23, 2024 at 08:38:53PM -0500, Steven Rostedt wrote:
> > Yes, rasdaemon uses libtraceevent (or a copy of it internally) that
> > reads the format file to find fields. You can safely add fields to the
> > middle of the event structure and the parsing will be just fine.  
> 
> Should we worry about tools who consume the event "blindly", without the
> lib?

I don't think that's a worry anymore. The offsets can change based on
kernel config. PowerTop needed to have the library ported to it because
it use to hardcode the offsets but then it broke when running the 32bit
version on a 64bit kernel.

> 
> I guess no until we break some use case and then we will have to revert.
> At least this is what we've done in the past...
> 

But that revert was reverted when we converted PowerTop to use libtraceevent.

-- Steve

