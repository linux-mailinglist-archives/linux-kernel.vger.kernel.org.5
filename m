Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE297F8818
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 04:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjKYDFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 22:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYDFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 22:05:32 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF36F170B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 19:05:38 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b2df2fb611so1625277b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 19:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700881538; x=1701486338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v2cuSqnvi/SCjlwUg4+09mEhsulM5HDD1xbtCjbVPcc=;
        b=X0V3CG7HGlSyEJ4JY7gqzkWyfnoN/nhESmRKbZS8oNUm/aH3qKrGtqufkFY96O9O41
         LKhGAT603p5BgwOWbtfbenq1HUZNwJCs2bmSUiSbFWA5qqyC+UQE5WAQ2GgkGWwgz7GQ
         zYVb0qKjFe/6zDVrYe1yU9GZd8tdbyCGO9kXvsXY98j3ZIyMJKCGlseEX+0+GtQNMxfu
         rUwCbHRlQxK3lC6Xply05+gw+diSF3L3aX+PvbifCqDlUh0KamXfw0gfwHEnA+fhMyxS
         nYalFdfpLY/Q4u1kbKaj/2Zh5v7CyMpphpYi3Oh45XpL/B0wn/6pC75lo0cv/88ev8yd
         0BlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700881538; x=1701486338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2cuSqnvi/SCjlwUg4+09mEhsulM5HDD1xbtCjbVPcc=;
        b=aWPNWbA3w1RGGVjhvM8xh+zps68THK3mtX5ZAhIyi0q6Uh88rHdUJWSywjLQvaec3g
         R/AfLp/nu+t3x5ap9UKTvN916DIiEwvDDiOWrdQkbwWmAY1/IdjO8ziGuWujK1HNlkfv
         YQeNmZA/na7MnSRdcO4vxjn0EPCzGQgrviWWF5QvC3BQlSKScXYylJ1kFFc83l7zALxR
         B5qCsfpk4OczYAlT2JPsUs7k5nWzBn+pUGsiins7LN5gcCrabx1akFs3SurYHtqOYAK5
         jf5na/wD6jpRx3HRhGOXSVieTF5hrwzWUDZ/VxxElvhFVu5HbzFpybLXbVVjx+IVpJ1g
         w2kA==
X-Gm-Message-State: AOJu0YzfYFZrecMgwXb9nwnC7+4/ve+46nsfuHDR6bus0j+63uK7k77F
        JC/seIEn05ERPwSO6yFvkXWmvQ==
X-Google-Smtp-Source: AGHT+IF/tcxnYHCzERgYTZ+eyXsK/xFB0JkEB6u83vwMMJ/2VFrw0AuR4/u4MvY5PszzqKRUadI9Ag==
X-Received: by 2002:a05:6808:1b1f:b0:3b6:cb6a:18b1 with SMTP id bx31-20020a0568081b1f00b003b6cb6a18b1mr5706881oib.32.1700881537965;
        Fri, 24 Nov 2023 19:05:37 -0800 (PST)
Received: from leoy-huanghe ([98.98.115.199])
        by smtp.gmail.com with ESMTPSA id q26-20020a62e11a000000b006b2677d3685sm3464906pfh.207.2023.11.24.19.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 19:05:37 -0800 (PST)
Date:   Sat, 25 Nov 2023 11:05:29 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     Nick Forrington <nick.forrington@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        vmolnaro@redhat.com
Subject: Re: [PATCH] perf test: Remove atomics from test_loop to avoid test
 failures
Message-ID: <20231125030529.GB178091@leoy-huanghe>
References: <20231102162225.50028-1-nick.forrington@arm.com>
 <alpine.LRH.2.20.2311242037260.11297@Diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.2311242037260.11297@Diego>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Fri, Nov 24, 2023 at 08:57:52PM +0100, Michael Petlan wrote:
> On Thu, 2 Nov 2023, Nick Forrington wrote:
> > The current use of atomics can lead to test failures, as tests (such as
> > tests/shell/record.sh) search for samples with "test_loop" as the
> > top-most stack frame, but find frames related to the atomic operation
> > (e.g. __aarch64_ldadd4_relax).

I am confused by above description.  As I went through the script
record.sh, which is the only test invoking the program 'test_loop',
but I don't find any test is related with stack frame.

Do I miss anything?  I went through record.sh but no clue why the
failure is caused by stack frame.  All the testings use command:

  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
    ...
  fi

@Nick, could you narrow down which specific test case causing the
failure.

[...]

> I believe that it was there to prevent the compiler to optimize the loop
> out or some reason like that. Hopefully, it will work even without that
> on all architectures with all compilers that are used for building perf...

Agreed.

As said above, I'd like to step back a bit for making clear what's the
exactly failure caused by the program.

Thanks,
Leo
