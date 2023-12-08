Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015C8809A09
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 04:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573025AbjLHDHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 22:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjLHDHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 22:07:20 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266EA1718
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 19:07:26 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54f4a933ddcso3789a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 19:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702004844; x=1702609644; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nW5R1L3whjb3H6LuQQAxkTyfGdke42PafpR59i/Lueo=;
        b=LCK9VudAWUsyGSyWgzzk3ltYcN2LIiiuO2udQttM5uC+aZ53d41KrcY4MjyAUIddJ4
         CFBjqKZi3MnDPwj4gioxKIe0NBle5/EVSShVjua84z8m9vofwZ3R62zW2eKMgtrLZX0N
         z9N0baazzhv6gxM9cI94fV6G9WmrUI+oRrOOn6RkUUoX4LRdVKwW3p+PHhRF/4USGRY3
         RzNNreKB1CB/e3e/MUdadTUlD5fqyeSvuuM5Ib5t44U9EO3y9EoxSMn6nV5PzutbV+gb
         IJB7xiXIrJhAgn6erwQqCZS9FMDwbGJccP9716u2Gf75V4sAB+acQuf2PsG7hkk12eNr
         BZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702004844; x=1702609644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nW5R1L3whjb3H6LuQQAxkTyfGdke42PafpR59i/Lueo=;
        b=dbrKbpDyCKk6wAuU8hPzZ5sdFfrtMALjkwc7wdhJdTM24aKH24FSM75cjRCoVc+iGu
         K1YIl8NUW4uRlxEEr+0gM1JVXa+RqJW2e1qeAtmOnJEeMMLttuRjjHxfTVG/WcR0VAsT
         eiVu3OSppm3uGtq9KJEIwEopU04y5cnAobnR6VIzAtEw9KKP7llEQLP5NQOyS2ammOMl
         RgURIGGJ+TQ0kpL7p6FieGDtu0rA90KXbvw1Ej+6oF4kCICdRe3a4cwAREJ3XtZUWiTx
         VZTCVCrDbV5xxDcaxIHSbHbGVZRhUeWrDCd2P8fbvr+z07KPJ3bRnpDjdc7zx6kgEInC
         YlqA==
X-Gm-Message-State: AOJu0YzP8kKQquTZfD2h3a0NjUzlQq7o9YjMP+BD/z6Lu9aOm4pCYV6q
        N/G1PRz2DPzzW0I6xTAW7BjqvWuoM8at+GrJuuPvSg==
X-Google-Smtp-Source: AGHT+IGWvJNjRaDyQ2HhpaiEblVY2IXDlHySVCSNNiEiHdaScFfbFUnbtFE3a/McmwsWNujrHeKQtXdK5ZwZiRHwQnU=
X-Received: by 2002:a50:c092:0:b0:543:fb17:1a8 with SMTP id
 k18-20020a50c092000000b00543fb1701a8mr14087edf.3.1702004844448; Thu, 07 Dec
 2023 19:07:24 -0800 (PST)
MIME-Version: 1.0
References: <20231207213410.417564-1-rmoar@google.com>
In-Reply-To: <20231207213410.417564-1-rmoar@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 8 Dec 2023 11:07:13 +0800
Message-ID: <CABVgOSnC86QafLEj6JE7-_ySMhg2zkGAvn3O0BYk1fzcqbv_7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kunit: tool: fix parsing of test attributes
To:     Rae Moar <rmoar@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 at 05:34, Rae Moar <rmoar@google.com> wrote:
>
> Add parsing of attributes as diagnostic data. Fixes issue with test plan
> being parsed incorrectly as diagnostic data when located after
> suite-level attributes.
>
> Note that if there does not exist a test plan line, the diagnostic lines
> between the suite header and the first result will be saved in the suite
> log rather than the first test case log.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Thanks, this looks good to me.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David
