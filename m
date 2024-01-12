Return-Path: <linux-kernel+bounces-24564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC00782BE51
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3D91F224C1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E63660B87;
	Fri, 12 Jan 2024 10:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TOBSJx8j"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03BF6167A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 10:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-555f581aed9so7312535a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 02:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705054450; x=1705659250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=beV7Rhdi0kiqh4zZhi4VOktqfy3N/cuEBR+yey5T860=;
        b=TOBSJx8jSKGFBC+mJN1osJiEZcRMy1j5s0G1vWqjpVYoGim1AKmHI3pO1M3GTPXUHv
         0c0CtEd8RqLA96yBabCOhwo/0XJkotQscy41sXns5FzW5mt4BLyQ61e/yfjLRBfLrfSz
         JZKlHuvw3UA52qVkePsjzvcrNxbRdI7RYKzyrWOckN4oUaM9tqTdo0+2aSEspLZtkI29
         l/xrf/H5udlje2GD5KSb0p3mk6oO3N1z81GRDbqBp6Eh3KYuV8VtrHwgDLaSeU0cxd25
         478elNsRrmPFxIbYF0aNK55VLuAU3VZ++7MOmMXw+TRpPm41IwoTeSuo1q+dT8j5x7nx
         YnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705054450; x=1705659250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beV7Rhdi0kiqh4zZhi4VOktqfy3N/cuEBR+yey5T860=;
        b=bjV66vHwHK28jLN/MQ7JfaNrVXy8TfUq0ck6u91sePzujqIT3xjTVAS4ZANXBeHFcX
         AieiY3ypoHBNuSBrmEzEg99ioQO2WzIJTfp6v9RGoY/zK3UkhhCjngXBoSCTgDzdjlzj
         Q6M+59D1Y17l309DwkJVOYr2iJFwHCxq20PeCUevNRj23zCjFdMT2rg3/aaFx9/Ze0VV
         O5MK76ezEZRlSRLNomKIyKF7FGkpqkZZAWWYEpbNBS/K/Qotm9rdZlKgX17WSQo8O/Wx
         K4+2VaVwB0MyACb9h9YpsHDp7PhqHrEXSUVxShEUrTR1bjYkwYqZhaSx5c2XFkhtJUwh
         SCcg==
X-Gm-Message-State: AOJu0YxLihJ4Sunxpo70Sexsy15O2cTfv9ey52q1O/lgo2vypa/MH8WI
	SeVG2XUiPOPkO8HcvtbP6JJvZ9bggETqRA==
X-Google-Smtp-Source: AGHT+IGKBv7ylcdpPBsr9seQCjgXwwrUIZIKjnmD0ahi7DEcHynX2zd+daRihbVe6Vax/CqMdjZj3Q==
X-Received: by 2002:a50:f68f:0:b0:558:d2a1:4346 with SMTP id d15-20020a50f68f000000b00558d2a14346mr310441edn.29.1705054449876;
        Fri, 12 Jan 2024 02:14:09 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ij9-20020a056402158900b005583e670df7sm1606871edb.73.2024.01.12.02.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 02:14:09 -0800 (PST)
Date: Fri, 12 Jan 2024 11:14:08 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 01/14] printk: nbcon: Relocate 32bit seq macros
Message-ID: <ZaEQ8KMPXcAXC8_p@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-2-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214214201.499426-2-john.ogness@linutronix.de>

On Thu 2023-12-14 22:47:48, John Ogness wrote:
> The macros __seq_to_nbcon_seq() and __nbcon_seq_to_seq() are
> used to provide support for atomic handling of sequence numbers
> on 32bit systems. Until now this was only used by nbcon.c,
> which is why they were located in nbcon.c and include nbcon in
> the name.
> 
> In a follow-up commit this functionality is also needed by
> printk_ringbuffer. Rather than duplicating the functionality,
> relocate the macros to printk_ringbuffer.h.
> 
> Also, since the macros will be no longer nbcon-specific, rename
> them to __u64seq_to_ulseq() and __ulseq_to_u64seq().
> 
> This does not result in any functional change.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

