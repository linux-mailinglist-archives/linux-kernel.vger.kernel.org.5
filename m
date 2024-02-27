Return-Path: <linux-kernel+bounces-82489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B8F868540
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D90B285CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8DD46AF;
	Tue, 27 Feb 2024 00:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lbh0E5lC"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620581848
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995215; cv=none; b=HP5PEXYJm/dWlTMQ/GlWHSycv+moKAZW8ZIB1fmOMApmO8y2PeIukYdgJOzRqMh0Ug5xYI+3DW69MhkBDXcJmTHk1Gg62FudJJjk8u2grDm4CN1w3v2FM9+ngiCdBLhjJG+QFvyFmx5qlKAJkp+Et0UzebF0rSJvEWF3r9gHaJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995215; c=relaxed/simple;
	bh=TxORtXxaPeaeUvIH5aVvdBg+Zjai6yqmN65Ed33TOKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mt1nqQ2NT8cSbPHMz306KB6EZ489eC7lFmfpNUfm7Q0p4awi3tpkDYgh60pgY+6meGtKSVU5tZcqZvd1L8vZHu1vJm3qSlDjCwNUFj6TjpQBO/lupCPOoGJuG8LlNnYYppG4U/z/iWRP621L/Dx69c9LCm9B6Z5C4g4cL7jJ9Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Lbh0E5lC; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2997a92e23bso2541733a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708995214; x=1709600014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=soUpkQvo6unU26F2AMxm/1yRW0fRVNaH6SBb9tzJmVc=;
        b=Lbh0E5lCnPE71vj6auHAklif3Mb1PhEPb+Q3k+Anvi+l81zKPqo2QtI8/0g5MbayAx
         ZC/rAjjWSstgrIFPADbMFL+YpCwn+RHiY9yK88/yca7Dhk+dK+5Zl471P8spDVgCcG4T
         Rq2S/6ObZvnmV5zxwIAPTXxIdSZ4vq11DBYZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708995214; x=1709600014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soUpkQvo6unU26F2AMxm/1yRW0fRVNaH6SBb9tzJmVc=;
        b=WAXfegvJl110pIGC2EC8JzaQbydu6KIH8BRrDDCtMsgCIMQAZGJS67Rv3DJsEF8HLh
         M6yZ6BJNqtbtIePoMmbn3j7ovlu/yTDSfFI34BmFk8j50L9kWY+FmGZ0L5+pJp0sv13E
         M9Ueh8yf6vVkULHFuey66iSqGab5MwtOXrF7JpmioWb2a3YkWUujUPZTkSQp2VqFbUcY
         oDY0NOxzG9sOz+hIqgKILmqrDVYuOSJbdjpEIJvFfmLwLPQGFomOeJb81YOkaTVd+1q8
         AR+y/tpgjQayNDy/Chr3JkJAciJl83irEdhZDkiwEVa/YL1tUg/tLdFRPz7dX0e5bJtm
         YlqA==
X-Forwarded-Encrypted: i=1; AJvYcCWr/AhDLCaOIi/2fWjbyQRfVvqhVtw4lVg1oE+TQianO55cpZMOnK8YqpCwvWtOGbHmxNFdDakWghm6inT3XiUDm5wip7H/oQPgZX2n
X-Gm-Message-State: AOJu0YylQvnFi/4n972AvPYBq9LQiPOTMA8O+KRzbs+ckZS8tH6VnVai
	kTuSLVPpR6gxKHgJKO1jE/OXki8GMcsmU+vpmmGUm4anjGQ3YU+Q/UDj5/ywQQ==
X-Google-Smtp-Source: AGHT+IE+2QwNGUqRpV9gCw9eBgDmcaY/8Tgc/ruaUDruqzYM+njjzZX5h8mfzxDu9AcxVJ1qJTW98w==
X-Received: by 2002:a17:90a:f40e:b0:299:29a5:d575 with SMTP id ch14-20020a17090af40e00b0029929a5d575mr6050194pjb.12.1708995213720;
        Mon, 26 Feb 2024 16:53:33 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x19-20020a17090ab01300b002990d91d31dsm7025335pjq.15.2024.02.26.16.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 16:53:33 -0800 (PST)
Date: Mon, 26 Feb 2024 16:53:32 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] scsi: lpfc: replace deprecated strncpy with strscpy
Message-ID: <202402261653.F65AAFDED3@keescook>
References: <20240226-strncpy-drivers-scsi-lpfc-lpfc_ct-c-v2-1-2df2e46569b9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-strncpy-drivers-scsi-lpfc-lpfc_ct-c-v2-1-2df2e46569b9@google.com>

On Mon, Feb 26, 2024 at 11:53:44PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect ae->value_string to be NUL-terminated because there's a
> comment that says as much; these attr strings are also used with other
> string APIs, further cementing the fact.
> 
> Now, the question of whether or not to NUL-pad the destination buffer:
> lpfc_fdmi_rprt_defer() initializes vports (all zero-initialized), then
> we call lpfc_fdmi_cmd() with each vport and a mask. Then, inside of
> lpfc_fdmi_cmd() we check each bit in the mask to invoke the proper
> callback. Importantly, the zero-initialized vport is passed in as the
> "attr" parameter. Seeing this:
> |	struct lpfc_fdmi_attr_string *ae = attr;
> ... we can tell that ae->value_string is entirely zero-initialized. Due
> to this, NUL-padding is _not_ required as it would be redundant.
> 
> Considering the above, a suitable replacement is `strscpy` [2].
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

