Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF60801AF5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 07:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjLBGEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 01:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLBGEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 01:04:24 -0500
X-Greylist: delayed 395 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Dec 2023 22:04:28 PST
Received: from mail-m607.netease.com (mail-m607.netease.com [210.79.60.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCAA1A6;
        Fri,  1 Dec 2023 22:04:28 -0800 (PST)
Received: from [172.23.111.174] (unknown [111.52.6.202])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 43688800059;
        Sat,  2 Dec 2023 13:56:45 +0800 (CST)
Message-ID: <7dd51893-4080-4090-bef9-0dd7451f0cd6@link.tyut.edu.cn>
Date:   Sat, 2 Dec 2023 13:56:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/bpf_doc: add __main__ judgement before main code
To:     Daniel Borkmann <daniel@iogearbox.net>, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, martin.lau@linux.dev
Cc:     ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231130145746.23621-1-2023002089@link.tyut.edu.cn>
 <e7286e2d-76ea-8b50-54bd-751b649f9a4e@iogearbox.net>
Content-Language: en-US
From:   Hu Haowen <2023002089@link.tyut.edu.cn>
In-Reply-To: <e7286e2d-76ea-8b50-54bd-751b649f9a4e@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSR9IVkhOT04fTB5OTEoeTFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKSlVOSVVNVUlLSVlXWRYaDxIVHRRZQVlPS0hVSkhKQkhPVUpLS1VLWQY+
X-HM-Tid: 0a8c2919cc14b03akuuu43688800059
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OAg6Izo4DTwyTws8Cy00Ky00
        PDJPCyFVSlVKTEtKT0JNTUtNSEpCVTMWGhIXVUlLSUhLS0lLQ0I7FxIVEFUPAg4PVR4fDlUYFUVZ
        V1kSC1lBWUpKSlVOSVVNVUlLSVlXWQgBWUFMSE9MNwY+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/12/1 23:46, Daniel Borkmann wrote:
> Hi Hu,
>
> On 11/30/23 3:57 PM, Hu Haowen wrote:
>> When doing Python programming it is a nice convention to insert the if
>> statement `if __name__ == "__main__":` before any main code that does
>> actual functionalities to ensure the code will be executed only as a
>> script rather than as an imported module.  Hence attach the missing
>> judgement to bpf_doc.py.
>>
>> Signed-off-by: Hu Haowen <2023002089@link.tyut.edu.cn>
>
> Thanks for the patch. What's the concrete value of this one? Do you plan
> to distribute the bpf_docs.py outside of the kernel tree? If it's not
> needed feels somewhat too much churn/marginal value.
>

Just noticed that the main code section does not follow the common rule
within the Python programming convention that any main code is ought to
be specified underneath the __name__ == "__main__" judgement to keep it
away from being executed when imported as a module wrongly. Hence I gave
this suggested change to both abide by this good convention and enhance
the main code's safety. After all it is recommended to have this change
carried out.

Thanks,
Hu Haowen


>>   scripts/bpf_doc.py | 81 +++++++++++++++++++++++-----------------------
>>   1 file changed, 41 insertions(+), 40 deletions(-)
>>
>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
>> index 61b7dddedc46..af2a87d97832 100755
>> --- a/scripts/bpf_doc.py
>> +++ b/scripts/bpf_doc.py
>> @@ -851,43 +851,44 @@ class PrinterHelpers(Printer):
>> ###############################################################################
>>   -# If script is launched from scripts/ from kernel tree and can access
>> -# ../include/uapi/linux/bpf.h, use it as a default name for the file 
>> to parse,
>> -# otherwise the --filename argument will be required from the 
>> command line.
>> -script = os.path.abspath(sys.argv[0])
>> -linuxRoot = os.path.dirname(os.path.dirname(script))
>> -bpfh = os.path.join(linuxRoot, 'include/uapi/linux/bpf.h')
>> -
>> -printers = {
>> -        'helpers': PrinterHelpersRST,
>> -        'syscall': PrinterSyscallRST,
>> -}
>> -
>> -argParser = argparse.ArgumentParser(description="""
>> -Parse eBPF header file and generate documentation for the eBPF API.
>> -The RST-formatted output produced can be turned into a manual page 
>> with the
>> -rst2man utility.
>> -""")
>> -argParser.add_argument('--header', action='store_true',
>> -                       help='generate C header file')
>> -if (os.path.isfile(bpfh)):
>> -    argParser.add_argument('--filename', help='path to 
>> include/uapi/linux/bpf.h',
>> -                           default=bpfh)
>> -else:
>> -    argParser.add_argument('--filename', help='path to 
>> include/uapi/linux/bpf.h')
>> -argParser.add_argument('target', nargs='?', default='helpers',
>> -                       choices=printers.keys(), help='eBPF API target')
>> -args = argParser.parse_args()
>> -
>> -# Parse file.
>> -headerParser = HeaderParser(args.filename)
>> -headerParser.run()
>> -
>> -# Print formatted output to standard output.
>> -if args.header:
>> -    if args.target != 'helpers':
>> -        raise NotImplementedError('Only helpers header generation is 
>> supported')
>> -    printer = PrinterHelpers(headerParser)
>> -else:
>> -    printer = printers[args.target](headerParser)
>> -printer.print_all()
>> +if __name__ == "__main__":
>> +    # If script is launched from scripts/ from kernel tree and can 
>> access
>> +    # ../include/uapi/linux/bpf.h, use it as a default name for the 
>> file to parse,
>> +    # otherwise the --filename argument will be required from the 
>> command line.
>> +    script = os.path.abspath(sys.argv[0])
>> +    linuxRoot = os.path.dirname(os.path.dirname(script))
>> +    bpfh = os.path.join(linuxRoot, 'include/uapi/linux/bpf.h')
>> +
>> +    printers = {
>> +            'helpers': PrinterHelpersRST,
>> +            'syscall': PrinterSyscallRST,
>> +    }
>> +
>> +    argParser = argparse.ArgumentParser(description="""
>> +    Parse eBPF header file and generate documentation for the eBPF API.
>> +    The RST-formatted output produced can be turned into a manual 
>> page with the
>> +    rst2man utility.
>> +    """)
>> +    argParser.add_argument('--header', action='store_true',
>> +                           help='generate C header file')
>> +    if (os.path.isfile(bpfh)):
>> +        argParser.add_argument('--filename', help='path to 
>> include/uapi/linux/bpf.h',
>> +                               default=bpfh)
>> +    else:
>> +        argParser.add_argument('--filename', help='path to 
>> include/uapi/linux/bpf.h')
>> +    argParser.add_argument('target', nargs='?', default='helpers',
>> +                           choices=printers.keys(), help='eBPF API 
>> target')
>> +    args = argParser.parse_args()
>> +
>> +    # Parse file.
>> +    headerParser = HeaderParser(args.filename)
>> +    headerParser.run()
>> +
>> +    # Print formatted output to standard output.
>> +    if args.header:
>> +        if args.target != 'helpers':
>> +            raise NotImplementedError('Only helpers header 
>> generation is supported')
>> +        printer = PrinterHelpers(headerParser)
>> +    else:
>> +        printer = printers[args.target](headerParser)
>> +    printer.print_all()
>>
>
>
