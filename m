Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1237F95DF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 23:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjKZWqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 17:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjKZWq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 17:46:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09941F5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 14:46:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED8EC433C7;
        Sun, 26 Nov 2023 22:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701038794;
        bh=bBtJBPnGKOxmvNx6m6LGRQ2WMGlCiOUMzE0689El0Ac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uYC5HxoVgbp/7AXqVGwnsdpu06o/uwJtQHE3QE19CVqe97L31u9RPONSu3b3KTS04
         ZAFpcF7Db7dKL99P10OaIf17NC79wf8izjEd9o7EVeM5fHz5CfuV6IhyPw09Jfw+fQ
         KLREBX7KFyCAKqx5ledmrscypbjKoUpvREFIc9M+VqeYysFmJqqNxsRqvEFYLV4/YE
         yfa6V0R9cVsIqn9UbTosNuwktr+ssEbnF5N8wvt8KO8Vpmbe+gTpYVmvtrcTJ/3A8s
         XGctVxKBCoTsQ5YBoRExphVFBlFtiAkCbaPy7JdG2OxweAW1vGPWJvKE6NF2+23/J3
         rRZi8bAhlChRQ==
Date:   Mon, 27 Nov 2023 07:46:30 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Petr Malat <oss@malat.biz>
Cc:     linux-kernel@vger.kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org
Subject: Re: [PATCH 2/2] bootconfig: Apply early options from embedded
 config
Message-Id: <20231127074630.993db80be06f03067d8a1aef@kernel.org>
In-Reply-To: <ZWADKWURCDZXyJTQ@ntb.petris.klfree.czf>
References: <20231121231342.193646-1-oss@malat.biz>
        <20231121231342.193646-3-oss@malat.biz>
        <20231123194106.08f5832f558fe806b1fd8098@kernel.org>
        <ZWADKWURCDZXyJTQ@ntb.petris.klfree.czf>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Fri, 24 Nov 2023 02:58:01 +0100
Petr Malat <oss@malat.biz> wrote:

> On Thu, Nov 23, 2023 at 07:41:06PM +0900, Masami Hiramatsu wrote:
> > On Wed, 22 Nov 2023 00:13:42 +0100
> > Petr Malat <oss@malat.biz> wrote:
> > > +	static int prev_rtn __initdata;
> > 
> > I would rather like 'done_retval' instead of 'prev_rtn'.
>  
> OK, I will rename it.
> 
> > > -	/* Cut out the bootconfig data even if we have no bootconfig option */
> > > -	initrd_data = get_boot_config_from_initrd(&initrd_size);
> > > -	/* If there is no bootconfig in initrd, try embedded one. */
> > > -	if (!initrd_data || IS_ENABLED(CONFIG_BOOT_CONFIG_EMBED_APPEND_INITRD))
> > > -		embeded_data = xbc_get_embedded_bootconfig(&embeded_size);
> > > +	if (prev_rtn)
> > > +		return prev_rtn;
> > >  
> > > +	embeded_data = xbc_get_embedded_bootconfig(&embeded_size);
> > >  	strscpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> > >  	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
> > >  			 bootconfig_params);
> > 
> > This copy & check should be skipped if IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE) because
> > this only checks "bootconfig" is in the cmdline.
> > Can you introduce following flag and initialize it here?
> > 
> > #ifdef CONFIG_BOOT_CONFIG_FORCE
> > #define bootconfig_enabled	(true)
> > #else
> > static bool bootconfig_enabled __initdata;
> > #endif
> 
> Even when CONFIG_BOOT_CONFIG_FORCE is set, we must call parse_args to find
> the location of -- to know where init options should be added. It's done the
> same way in the current code.

Ah, got it.

> 
>  
> > > -
> > > -	if (IS_ERR(err) || !(bootconfig_found || IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE)))
> > > -		return;
> > > -
> > > +	if (IS_ERR(err) || !(bootconfig_found || IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE))) {
> > > +		prev_rtn = embeded_data ? -ENOMSG : -ENODATA;
> > > +		return prev_rtn;
> > 
> > Than we don't need to set a strange error value...
> 
> It's used for error logging as the current code emits a different
> messages in these situations, but I will try to refactor it.

Yeah, I recommend you to set a global flag if initializing something.

> > > +	}
> > >  	/* parse_args() stops at the next param of '--' and returns an address */
> > >  	if (err)
> > >  		initargs_offs = err - tmp_cmdline;
> > >  
> > > -	if (!initrd_data && !embeded_data) {
> > > -		/* If user intended to use bootconfig, show an error level message */
> > > -		if (bootconfig_found)
> > > -			pr_err("'bootconfig' found on command line, but no bootconfig found\n");
> > > -		else
> > > -			pr_info("No bootconfig data provided, so skipping bootconfig");
> > > -		return;
> > > +	if (!embeded_data) {
> > > +		prev_rtn = -ENOPROTOOPT;
> > 
> > Also, we can recheck xbc_get_embedded_bootconfig(&embeded_size) later instead of
> > using this error code.
> 
> ok, I will try to refactor the error logging. Calling
> xbc_get_embedded_bootconfig is cheap.

Yes.

> 
> > > +		return prev_rtn;
> > >  	}
> > >  
> > >  	ret = xbc_init(embeded_data, embeded_size, &msg, &pos);
> > > -	if (ret < 0)
> > > -		goto err0;
> > > +	if (ret < 0) {
> > > +		boot_config_pr_err(msg, pos, "embedded");
> > > +		prev_rtn = ret;
> > > +		return prev_rtn;
> > > +	}
> > > +	prev_rtn = 1;
> > 
> > This function should be splitted into init_embedded_boot_config() and
> > apply_boot_config_early(). The latter one should not be called twice.
> >
> > > .....
> > > +
> > > +static void __init setup_boot_config(void)
> > > +{
> > > +	const char *msg, *initrd_data;
> > > +	int pos, ret;
> > > +	size_t initrd_size, s;
> > > +
> > > +	/* Cut out the bootconfig data even if we have no bootconfig option */
> > > +	initrd_data = get_boot_config_from_initrd(&initrd_size);
> > > +
> > > +	ret = setup_boot_config_early();
> > 
> > Because you should not apply early_params here, you need to call only
> > init_embedded_boot_config() here.
> 
> setup_boot_config_early() must be called from 2 places, because there is
> no guarantee the architecture specific code calls parse_early_param() - it's
> not mandatory. If it's not called by architecture, it's called quite late
> by start_kernel(), later than setup_boot_config().

Right. I meant that you can skip the second one if the first one is
called.

> I want to avoid different behavior on different architectures, so I always
> process early options in the embedded config only, although on some
> architectures even these from initrd could be used, but it could cause
> issues in the future if the architecture would need to switch.

Ah, I got it. There are 2 cases.

- If setup_arch() calls parse_early_param(), the 2nd setup_boot_config_early()
  in the setup_boot_config() will do nothing.

- If setup_arch() does not call parse_early_param(), the 1st
  setup_boot_config_early() in the setup_boot_config() will apply early params
  but the 2nd setup_boot_config_early() in the parse_early_param() will do nothing.
  
OK. And can you write a comment it?

> 
> 
> > > +	if (ret == -ENOMSG || (ret == -ENODATA && initrd_data)) {
> > 
> > Also, this can be
> > 	if (!bootconfig_enabled) {
> > 		if (initrd_data || xbc_get_embedded_bootconfig(&s))
> > 
> > > +		pr_info("Bootconfig data present, but handling is disabled\n");
> > > +		return;
> > 
> > 
> > > +	} else if (ret == -ENODATA) {
> > > +		/* Bootconfig disabled and bootconfig data are not present */
> > > +		return;
> > 
> > this can be removed.
> > 
> > > +	} else if (ret == -ENOPROTOOPT) {
> > 
> > This should be
> > 
> > 	} else {
> > 
> > > +		/* Embedded bootconfig not found */
> > > +		if (!initrd_data) {
> > > +			pr_err("'bootconfig' found on command line, but no bootconfig data found\n");
> > > +			return;
> > > +		}
> > > +		ret = xbc_init(NULL, 0, &msg, &pos);
> > > +		if (ret)
> > > +			goto err0;
> > 
> > > +	} else if (ret < 0) {
> > > +		/* Other error, should be logged already */
> > > +		return;
> > 
> > So this is checked at first.
> > 
> > > +	} else if (initrd_data && !IS_ENABLED(CONFIG_BOOT_CONFIG_EMBED_APPEND_INITRD)) {
> > 
> > And as I pointed, we can remove CONFIG_BOOT_CONFIG_EMBED_APPEND_INITRD so this case
> > should be removed.
> 
> I have added BOOT_CONFIG_EMBED_APPEND_INITRD, because it's not backward
> compatible change and I didn't want to risk breaking current use cases.
> My change tries to get early options working without affecting how
> other options are handled, but I think appending the config is more
> reasonable behavior and if you do not see it as a problem to not be
> backward compatible here, I will delete the "replace" behavior.

That's a good point. OK if disabling CONFIG_BOOT_CONFIG_EMBED_APPEND_INITRD,
it must skip setting early_params to avoid "hidden setting" from the
embedded bootconfig.

Thank you,

> 
> I will try to refactor the error handling.
>   Petr


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
