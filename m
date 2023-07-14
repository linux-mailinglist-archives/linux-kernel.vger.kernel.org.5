Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C72A754012
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbjGNQ6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjGNQ6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:58:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCE8358E;
        Fri, 14 Jul 2023 09:58:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9EC031F750;
        Fri, 14 Jul 2023 16:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689353881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3GpL3SAU4UYjxuI87qVTDXsPz5t7JNfto7bmoN8MBNc=;
        b=P94IF4rvbaGL6Y0u4KZ1FyLbRjYenZq9wdX/Bo35qp5GuZ6sSXskRyjJSrmYmJQwfaqUs+
        sXQedZsnImNBOwJfLUqAzzKoOUdQ1keZ7FStY96P+A+Gmmi/WAAgmJrO1VwYlZ9dMmDKe/
        M+5LxT0odIOqOgYb+Y+Ag6zSldSGMH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689353881;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3GpL3SAU4UYjxuI87qVTDXsPz5t7JNfto7bmoN8MBNc=;
        b=pHz0RJu4wxUdHnoFijoc/IefLA59NKobliL7o5TvzftLGlLdx6+5M0ytBWkubqUFRsRNF4
        dKSx/mdTS4awYDCA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 55D8A2C142;
        Fri, 14 Jul 2023 16:58:01 +0000 (UTC)
Date:   Fri, 14 Jul 2023 18:58:00 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kmod v2 3/4] kmod: Add config command to show compile
 time configuration as JSON
Message-ID: <20230714165800.GO9196@kitsune.suse.cz>
References: <20230711153126.28876-1-msuchanek@suse.de>
 <20230712140103.5468-3-msuchanek@suse.de>
 <ZLFpM+H2bfkJx65S@fjasle.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLFpM+H2bfkJx65S@fjasle.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 05:26:43PM +0200, Nicolas Schier wrote:
> On Wed, Jul 12, 2023 at 04:00:47PM +0200 Michal Suchanek wrote:
> > Show prefix (where configuration files are searched/to be installed),
> > module compressions, and module signatures supported.
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > v2: mention module signature in commit message
> > ---
> >  man/kmod.xml |  6 ++++++
> >  tools/kmod.c | 39 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 45 insertions(+)
> > 
> > diff --git a/man/kmod.xml b/man/kmod.xml
> > index 0706ad58c2cc..f992a500f836 100644
> > --- a/man/kmod.xml
> > +++ b/man/kmod.xml
> > @@ -71,6 +71,12 @@
> >            <para>Show the help message.</para>
> >          </listitem>
> >        </varlistentry>
> > +      <varlistentry>
> > +        <term><command>config</command></term>
> > +        <listitem>
> > +          <para>Show compile time options in JSON.</para>
> > +        </listitem>
> > +      </varlistentry>
> >        <varlistentry>
> >          <term><command>list</command></term>
> >          <listitem>
> > diff --git a/tools/kmod.c b/tools/kmod.c
> > index 55689c075ab1..5a13716955c1 100644
> > --- a/tools/kmod.c
> > +++ b/tools/kmod.c
> > @@ -37,9 +37,11 @@ static const struct option options[] = {
> >  };
> >  
> >  static const struct kmod_cmd kmod_cmd_help;
> > +static const struct kmod_cmd kmod_cmd_config;
> >  
> >  static const struct kmod_cmd *kmod_cmds[] = {
> >  	&kmod_cmd_help,
> > +	&kmod_cmd_config,
> >  	&kmod_cmd_list,
> >  	&kmod_cmd_static_nodes,
> >  
> > @@ -95,6 +97,43 @@ static const struct kmod_cmd kmod_cmd_help = {
> >  	.help = "Show help message",
> >  };
> >  
> > +static const char *compressions[] = {
> > +#ifdef ENABLE_ZSTD
> > +			"zstd",
> > +#endif
> > +#ifdef ENABLE_XZ
> > +			"xz",
> > +#endif
> > +#ifdef ENABLE_ZLIB
> > +			"gz",
> > +#endif
> > +			NULL
> > +};
> > +
> > +static int kmod_config(int argc, char *argv[])
> > +{
> > +	unsigned i;
> > +	printf("{\"prefix\":\"" PREFIX "\""
> > +			",\"module_signature\":["
> > +#ifdef ENABLE_OPENSSL
> > +			"\"PKCS#7\","
> > +#endif
> > +			"\"legacy\"]"
> > +			",\"module_compression\":[");
> > +	for(i = 0; compressions[i]; i++) {
> > +		printf("%s\"%s\"", i ? "," : "", compressions[i]);
> > +	}
> > +	printf("]}\n");
> > +
> > +	return EXIT_SUCCESS;
> > +}
> > +
> > +static const struct kmod_cmd kmod_cmd_config = {
> > +	.name = "config",
> > +	.cmd = kmod_config,
> > +	.help = "Show compile time options in JSON",
> > +};
> > +
> >  static int handle_kmod_commands(int argc, char *argv[])
> >  {
> >  	const char *cmd;
> > -- 
> > 2.41.0
> 
> If kmod could show selected configs without some (JSON) syntax
> around, it could simplify its proposed use in kbuild. E.g.:
> 
>     kmod config prefix 2>/dev/null
> 
> instead of
> 
>     kmod config &>/dev/null && kmod config | jq -r .prefix

Which would no longer hold for whole module directory:

      kmod config &>/dev/null && kmod config | jq -r .module_directory || echo /lib/modules

      vs

      kmod config module_directory &>/dev/null && kmod config module_directory || echo /lib/modules

Also JSON has standardized syntax for lists and users that can parse
JSON directly can load the whole configuration at once without several
calls to kmod config or pkg-config.

Thanks

Michal
