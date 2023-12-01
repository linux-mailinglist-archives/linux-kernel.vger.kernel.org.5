Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F786801747
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441853AbjLAXEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjLAXEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:04:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5463103
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 15:05:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70A3C433C9;
        Fri,  1 Dec 2023 23:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701471900;
        bh=8QM9HT8onEgqQAddB8/SA3iCORef5quAS35T+XsDQRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TaPocXJMVe5qtUJSPlh/Z3bfVfmippRoj18kOiQe5GTipg6nooHM35LWW5rZoxJ9f
         neh3nMj12wovWs1Pc5X11kTcwaeNu8A6hKZZgKgK4pDa2rH1REtHMO15GDQDBAvy9R
         wPCgBf+kLJAqpnZpgWqakzhTz58Cbe9AscZKZYsk=
Date:   Sat, 2 Dec 2023 00:04:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     Francis Laniel <flaniel@linux.microsoft.com>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 5.15 00/69] 5.15.141-rc1 review
Message-ID: <2023120223-diagnosis-niece-3932@gregkh>
References: <20231130162133.035359406@linuxfoundation.org>
 <CAEUSe78tYPTFuauB7cxZzvAeMhzB_25Q8DqLUfF7Nro9WsUhNw@mail.gmail.com>
 <2023120134-sabotage-handset-0b0d@gregkh>
 <4879383.31r3eYUQgx@pwmachine>
 <2023120155-mascot-scope-7bc6@gregkh>
 <4cf40ef6-058f-4472-88c9-3dc735175c85@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cf40ef6-058f-4472-88c9-3dc735175c85@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 08:34:26AM -0600, Daniel Díaz wrote:
> Hello!
> 
> On 01/12/23 3:44 a. m., Greg Kroah-Hartman wrote:
> > Please take some time with a cross-compiler on the above listed
> > architectures and configurations to verify your changes do not break
> > anything again.
> 
> It failed in more architectures than we initially reported. FWIW, this error can be easily reproduced this way:
> 
>   tuxmake --runtime podman --target-arch arm     --toolchain gcc-8  --kconfig imx_v4_v5_defconfig

Fails for me:

$ ~/.local/bin/tuxmake  --runtime podman --target-arch arm     --toolchain gcc-8  --kconfig imx_v4_v5_defconfig 
Traceback (most recent call last):
  File "/home/gregkh/.local/bin/tuxmake", line 8, in <module>
    sys.exit(main())
             ^^^^^^
  File "/home/gregkh/.local/pipx/venvs/tuxmake/lib/python3.11/site-packages/tuxmake/cli.py", line 170, in main
    build.run()
  File "/home/gregkh/.local/pipx/venvs/tuxmake/lib/python3.11/site-packages/tuxmake/build.py", line 652, in run
    self.prepare()
  File "/home/gregkh/.local/pipx/venvs/tuxmake/lib/python3.11/site-packages/tuxmake/build.py", line 318, in prepare
    self.runtime.prepare()
  File "/home/gregkh/.local/pipx/venvs/tuxmake/lib/python3.11/site-packages/tuxmake/runtime.py", line 423, in prepare
    self.prepare_image()
  File "/home/gregkh/.local/pipx/venvs/tuxmake/lib/python3.11/site-packages/tuxmake/runtime.py", line 443, in prepare_image
    do_pull()
  File "/home/gregkh/.local/pipx/venvs/tuxmake/lib/python3.11/site-packages/tuxmake/utils.py", line 36, in retry_wrapper
    ret = func(*args, **kwargs)
          ^^^^^^^^^^^^^^^^^^^^^
  File "/home/gregkh/.local/pipx/venvs/tuxmake/lib/python3.11/site-packages/tuxmake/runtime.py", line 441, in do_pull
    subprocess.check_call(pull)
  File "/usr/lib/python3.11/subprocess.py", line 408, in check_call
    retcode = call(*popenargs, **kwargs)
              ^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/subprocess.py", line 389, in call
    with Popen(*popenargs, **kwargs) as p:
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/subprocess.py", line 1026, in __init__
    self._execute_child(args, executable, preexec_fn, close_fds,
  File "/usr/lib/python3.11/subprocess.py", line 1950, in _execute_child
    raise child_exception_type(errno_num, err_msg, err_filename)
FileNotFoundError: [Errno 2] No such file or directory: 'podman'

Are you sure that's the right command line to use?  :)

thanks,

greg k-h
