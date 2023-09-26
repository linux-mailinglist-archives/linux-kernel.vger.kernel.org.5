Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95F37AF44F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjIZToF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjIZToD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:44:03 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3B0121;
        Tue, 26 Sep 2023 12:43:57 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3512f905f6cso20474435ab.3;
        Tue, 26 Sep 2023 12:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695757436; x=1696362236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZysiqfTQ6hkM6jDfZN72nc6S9wN6Tq8p5sHukAaays=;
        b=bTD/lTusib18TTJMRirapJTG1KrX81Cqunib68bZufBD+oYt3fmw0pxZIUoyBWYNwA
         F0Sd2J0T53GOrpyG7//JCqPTd9YR2mq9SVNRAUUl7Xwfv4VcwKdO45lmpf1Ya/6s3fOw
         IuKIxbzKW+Qg9MblAFZLN8tpdcDoNU67nXgPWxg+HOtXc1WzsBo07aNn3ov9mzRNHYdN
         Bcvl0uO+DwHWUfqE0geykWpuMtVH8Iqtj8+Nt+Nozo64/gPnBxJGVScHl3kxvDvn6Y+W
         0TrvMwvN+z5MRZ7NQ+MiulPzfj9QSgj1y+ur7u2Aql1QcxeZYK8aXywt8ifL4QY6s7+T
         xa8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695757436; x=1696362236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZysiqfTQ6hkM6jDfZN72nc6S9wN6Tq8p5sHukAaays=;
        b=AnMk5UKZJB9q+KsFcVyXOqcQZ7uXZzBE7tQLvEEmVo/H9n4Rx40ibqP67yJxwXb1Dg
         c9TAlNgTv8AKaaI+8kxEPvO1Q+NkISHonI4HA6mnMSuRiN7Zob7Iqv6rNLc8DoycKAzS
         UfkX+wjOmdBkdxJo8iVHZ0o7/3OUs6M1Y59ioUeycsM037+aWwVcd8xGyzffkf+ghnyI
         3HkuZ+mh0xbO7z6wAVkabKXj+0WmZkDDTPJpMr/1OeuUqFavagDjG2LZUTXYJdGi6lk0
         JPIeDF98NMrJ0jBSOowM9kHbwcySVaNqizYmdx2XK35AdXqaTwCruu/1mGZQ1ySf9xOT
         34Kw==
X-Gm-Message-State: AOJu0YwnPU+NABNhTGvHoW/Ft30iNds60DmgOpGbEradAy4NDwiv0fdm
        4pHoqsn82mxPFSCExgTY5AEoBrEkB+E=
X-Google-Smtp-Source: AGHT+IGg7ubIXfGmSu+gIkFUgJFSl1LPYB+T9ILwusYpeGYdP8G6pLMVR3folw0eHLS5iO+Cox0+ug==
X-Received: by 2002:a05:6e02:1bcb:b0:351:59db:a215 with SMTP id x11-20020a056e021bcb00b0035159dba215mr2132024ilv.18.1695757436524;
        Tue, 26 Sep 2023 12:43:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k1-20020a02c641000000b0042b09036e5fsm3585824jan.175.2023.09.26.12.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 12:43:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 26 Sep 2023 12:43:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v4] regulator (max5970): Add hwmon support
Message-ID: <edebb3a6-a116-49dd-9571-3f56a618117f@roeck-us.net>
References: <20230919054824.3368656-1-naresh.solanki@9elements.com>
 <ZRL4j32syAhYVu0y@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRL4j32syAhYVu0y@finisterre.sirena.org.uk>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 05:28:15PM +0200, Mark Brown wrote:
> On Tue, Sep 19, 2023 at 07:48:23AM +0200, Naresh Solanki wrote:
> > Utilize the integrated 10-bit ADC in Max5970/Max5978 to enable voltage
> > and current monitoring. This feature is seamlessly integrated through
> > the hwmon subsystem.
> 
> Guenter, are you OK with the hwmon side of this?

Sorry, I lost track. Not really; see my response to the patch.

I think the memory allocation in that driver is a bit too complicated.
It trades simplicity for minor memory savings, and even those savings
are questionable. It would have been much easier and simpler to just
add a two-element regulator_dev array to struct max5970_regulator
and live with the "lost" memory if only one of them is used. I suspect
that would have consumed less memory and code overall.

Guenter
