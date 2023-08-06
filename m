Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F0C77153A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjHFNT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHFNTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:19:25 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEFDA6;
        Sun,  6 Aug 2023 06:19:23 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so2367328b3a.1;
        Sun, 06 Aug 2023 06:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691327963; x=1691932763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XV4+dSNXuo7Q7scvC/FWLgz+b4Nc39IkSqkv1aDZyoc=;
        b=I/3zpj6AXdKrdX1vSp1xzwe7Osbct+DK3FBhE4ZU+CP8uDoIO3+ssAi6pNGZHsBNea
         mN/zVjd1tql9PyhH/j1jXjywfiQLezcOK3dJikILqmp4IxT6Ek8HPXgzbQQqTXx5rv2G
         K1gXOoKcDpQ10dgAV6L2fcglbhKzyNikY7HdYQ0Jyx6AbMZZ+yDpkuuOPhLPilebu4ze
         fh6T7xmKb2whtXK0VC8X5H7E3kkUkXwDr98oM72t4w+28A5kcS5UlBgCx2atenmrA1FO
         ygr8jPjMLTgFUIfXSTzIsD8hjTqJsD9/EkmgPfmyaZvyiOY9rg1KC9dEuqog+hcs+cVO
         hd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691327963; x=1691932763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XV4+dSNXuo7Q7scvC/FWLgz+b4Nc39IkSqkv1aDZyoc=;
        b=O7hZfFFMfdL5bDo/bq+8VWWPOMquJpQoitz4DhIolfCPQqGHDIinkKYFSDqrGc57ok
         I0iUp+u+4B8EOBCf3QkylusThiGmORAEgU4eu4fLMaUpoH+DMoHUB8RaK7FHwS8iO+60
         TWFJuakgs4zxwm/bVc9jFwqqn8iwsyEqdXwL8lXOhD3jFFyKV3BhX5YWvwrF0bthd0Fx
         uPo3gUmWM0gP8X8UwZT2kPng4N4HfHv6c//nY/HZqp0J9ps7U3owEzmHBJz0DACL2XhF
         CrtD9bMHZI+9+iiIlSut0iHIRfGHNjpJAPoQVOmR6TVjEHleCdF9xNZKo91MQm5HOFa/
         pB+Q==
X-Gm-Message-State: AOJu0YzUzGPgezEtM/wUh87j8QRRKFkH4PP96ppeGdED1+d8QDXBEsgN
        4MN7dR0YjlNScRVl1t6NVY0=
X-Google-Smtp-Source: AGHT+IGOxDmP99wg57Gr1jkhvnH/5Alxi258Vy2pd8IpOOSgMISeKOw1CG18Cqqo52FGXXQGFds6ag==
X-Received: by 2002:a05:6a00:24cd:b0:67a:52a7:b278 with SMTP id d13-20020a056a0024cd00b0067a52a7b278mr5380913pfv.9.1691327963192;
        Sun, 06 Aug 2023 06:19:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78298000000b0064378c52398sm4420661pfm.25.2023.08.06.06.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 06:19:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 6 Aug 2023 06:19:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] serial: core: Revert port_id use
Message-ID: <b8829d4b-d221-49ce-b0cd-e82dc79be719@roeck-us.net>
References: <20230806062052.47737-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230806062052.47737-1-tony@atomide.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2023 at 09:20:50AM +0300, Tony Lindgren wrote:
> Guenter reports boot issues with duplicate sysfs entries for multiport
> drivers. Let's go back to using port->line for now to fix the regression.
> 
> With this change, the serial core port device names are not correct for the
> hardware specific 8250 single port drivers, but that's a cosmetic issue for
> now.
> 
> Fixes: d962de6ae51f ("serial: core: Fix serial core port id to not use port->line")
> Reported-by: Guenter Roeck <groeck7@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
