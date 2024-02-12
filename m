Return-Path: <linux-kernel+bounces-61348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04653851158
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36AEC1C22B99
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA61839843;
	Mon, 12 Feb 2024 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="slSS0wKF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2330A3A1B7;
	Mon, 12 Feb 2024 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734677; cv=none; b=V1Nm/NGa6YxshZylnQcWqaVZ0S3N3/Dd9bpuXaDdBtBZiHIWqhp6THx+E0kHXF06YPYfQdEwrKl5L/Ip068y9KaTUApPZvt8DkPsn/aaqvo4TS9LG/hEBQpT7rqxSA9dmVmBXBT6ApC/38OWwBLVTxSJHH0H2IGXrcKlAMH9zWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734677; c=relaxed/simple;
	bh=1Da0/DMjh5jC40KWF36hmD167HiYbe6VGLGiN6+EOZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXkJbjo21WLsxXWg9xEqn0MXN4P50o0oIBtJY6N1PsM2oxesI3iYoFQm7D2Iykj3Y5O5LofRNpQlfvmJ/g2h3oh0a8j8pgPtOsG6RxMnUbL03Iwxg0EEhS4tRey9Bt89GIOcX+oxmUCjqUOvPjSNSkWij5lOTC8dVU70HGVi6m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=slSS0wKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB1FC43394;
	Mon, 12 Feb 2024 10:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707734676;
	bh=1Da0/DMjh5jC40KWF36hmD167HiYbe6VGLGiN6+EOZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=slSS0wKFkfcyIET03u1K8ISsRUBgHmeTeW7JXq7Hgekjzt80kPsKab34n/6p5qIRl
	 mjVDYgXNTcOQeKrNcOhkNkt0RHoKj1R8+oltlQuHKXtWdzL+5q2da8gsDY8exI9eEe
	 9a9++SciZK5Q6Xc8EShZALY4pJt2wRzEWusoeTzE=
Date: Mon, 12 Feb 2024 11:44:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH] ACPI: bus: make acpi_bus_type const
Message-ID: <2024021222-overhead-kudos-3565@gregkh>
References: <20240211-bus_cleanup-acpi-v1-1-08540c6e9458@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211-bus_cleanup-acpi-v1-1-08540c6e9458@marliere.net>

On Sun, Feb 11, 2024 at 12:37:11PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the acpi_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

