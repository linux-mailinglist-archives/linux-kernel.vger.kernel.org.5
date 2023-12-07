Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB612807F98
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 05:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjLGEb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 23:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLGEbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 23:31:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B211110
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 20:31:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC736C433C8;
        Thu,  7 Dec 2023 04:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701923486;
        bh=kXIJUor9ElBEpFLvPFxOjMdnEsdR503iCyUYYHzxWVI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KHeL4TPUYOIECb1vHK+aOledQimw9bL4gwqGGho3WD15mq/yBg68+RQZdTu/JkUfV
         9irMk6GhTTioGgFclToFgorG9qwW9yPyzkDuCYNV8STsTkfL5Zwd/ziZ1+pPZgSXLt
         CNaLUTnaZ6fj+0IJ2yZalyYfcjYEt0IBSSrjhUtSrNv4mMkDwlJL/9S9DmKSA+hRki
         PODjxZnxDZ8OqRpK806qD5nyEFwu2c1JA+Uprtn5422DQa5cAoC/YnHCwKD1ytdpIh
         b0ZL7aqeNPZ2l6tCNrdD3wMN3s5CjP+0ywGIRESzXd6BKJGWxxDaSu2lX3Ac1qWRxL
         cV+tHrW8FZVFg==
Message-ID: <68e7665a3962c05654bff4e8627f32bed81dc4f3.camel@kernel.org>
Subject: Re: [PATCH v1] selftests/sgx: Skip non X86_64 platform
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Zhao Mengmeng <zhaomzhao@126.com>, dave.hansen@linux.intel.com,
        shuah@kernel.org, jethro@fortanix.com, bp@suse.de
Cc:     linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Date:   Thu, 07 Dec 2023 06:31:21 +0200
In-Reply-To: <20231206025605.3965302-1-zhaomzhao@126.com>
References: <20231206025605.3965302-1-zhaomzhao@126.com>
Autocrypt: addr=jarkko@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBF0RXVoBEACq7dxNqGliHRIUjKeA0Ajj8R0JiNRbhayBAmCmjfDh6m/QTNfyCmFBv6ZPe4EbBEyCgcFxerS0qgkaRD0FApKgtrX842rkwDyyhTA222rkv5Q/U2SY1Hi55kekBcAgYHVQzhvHnRrckvE7YxDlH06mnUGlL63s9NI/xnhtJvn92rLNvWqAyn+48Ud/EcE9oBo6vvq10O0UAHN/PEsyqtThN9tlTEKH8IMXmy1FAC70Ov8Ap63ZJT2RE7H4wbIYrHOOxarfHaKHcKy+UjZBhuQ54sGxxch2kXQCfkXOY7Ab7KKNkb4u2jDc6lyz8TJlc8Twi5KQcWBzomnYy5R0OJ01g6byY7vCSwAfCSp87P50F5O2pmjqd82mdB3Noy+CWIlV1kjMjaJglTyFGym7CWkvx7+yP+Jjq643aIbveN/Tx5OYZIhtSMRtJDzT+nDIgD83NyHL6JHO3LzKZEw6yZJWWSXyK9P5H8RX7ipWf3o3NaUCcs1K8wyTcgBZ/GT9X9SprH1ySYAGJz+G1UyPMQT1V4OirkQaMfN0Ht7jl6gEXXOs0Ks1sOdaKZUFIGn9P1cNRixp34Bw3edL4ZjNljXZa12MqzbaArTCm+WzJqrvkToOx2bqU37Y1vNskOBdYkCvWhKsIf8Gj5LZiVjFnX27bXeLv6Gd3asJ4qcQAl06+wARAQABtChKYXJra28gU2Fra2luZW4gPGphcmtrby5zYWtraW5lbkBpa2kuZmk+iQJXBBMBCgBBAhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAhkBFiEEUQfmbTR4ipPjInyQOrBUhsd1L+EFAmSlnJMFCQl1crkACgkQOrBUhsd1L+EPKw/9EnoAjcbK+duuIN4JA6iXCfdWrYK8DhvaMgfNIbH4ZrtbMYwAPsHeZTv/C47pf48sp200OvdQoA2qoYdtX+I1JLhz7aaRtemBp1lwZEESeNG5j
        0EwCSLeR6ITQanlpnj8FQ0MnLi8yKf8crWR8QyKlE96zT1yBFxNsjveGHBpW9syHjSFUZOLVA9JVSv6eSGobvU265EPxekVH3+GreSzs/lXWOMvXdLONbUtRJSktq1/p8T5m+btNxRKRi16gQOK8gZL/VRXg0/GLhNgobOniAYKz/q9pM/6vQWDzVeg+ur1HHbln/C28DJNubV8+4VnmZGWDpb2AOrEVX8xXyPr6MZmsPdf0/X5nSHDjF8+NOwWfPcdIu+ZmPKX0kAzDtefDoXD54dm13WvPVxH1zS1hz66LKRmEhutXUpE05U+XBrpxlXGKEU3MF/XeaMN04s6JktjXyIyAeG7G7TrexHcDEmi7bbUhzPCHMHnL3ialXDH59hpzdYBMiFkMiQ1xv45ow5W3AsCkfgljEG4GAnLbvnFJgbcvdYhR5QEfS2/vBXLrmHsi+cNlGuD9maf22ymiUJEdAe9AtwapT6YLNSlHuOF4OhmBemYkmTAYB6Jo/2jD5sSDnQXglO/Ib1+qh9Adj/iCgjavijojl3kebWNcusZGspuQpYQKoKHFSZLyqe0I0phcmtrbyBTYWtraW5lbiA8amFya2tvQGtlcm5lbC5vcmc+iQJUBBMBCgA+AhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEUQfmbTR4ipPjInyQOrBUhsd1L+EFAmSlnJ8FCQl1crkACgkQOrBUhsd1L+H4UxAAnw2J8ew6vDB+vAK2snuNKUaVsyZX2EPJJ9WZStGkCyEzbnG/a3dk4ktpGlNLpk9tJJKTpb88efDIkp/Xa1fIUuOP75QQO8lNePX8lsc1aVWwNr4QHqTWe1Jgr1rBE29qeZA1R/poAMezI3Rrn5YEchexdDqFICba6KL2Wzl/yFR2puXMZoscVen3+NjyXE2UZiLdH0F/zacr2sIiwzKwp3Ej3m+fXmvxp+EPvRlt9LzxiTnDNKAy3A+xBec2uNveAM
        uB60i2GJES880Q4f/gPPiQiLJteqJcqz0GfosXSqInUlGM+6kDUG4wYaA+fXLux9orO0pVi9q71tFgSNjRNtp17PmdpjQHJRY/+jd621DETWs8gSa3m3gyyyAhkyjvw3TyOaR8oN94AB+ygNWN7Klgfyr+4KrulXKjMI39SnXoxbnWSfVwSHGsZUFpiU+B9GuMruA0piQgjp+rVr8bfQre+f4PrgwGB474qvECfJcrS+bLk5raOwCReM1aSfprNECgQB4qvfQUM14QlyeAzbGIKYff2vZ2HrmjFpIKsuuqvJOVdmhPlMaANBh+dCrkCScP+xbCbhtNiJu7pZCxlbSsf1Z1IlmE0E/kbePCgi8M2SQ+/F+4wPtaP8mAt63v5ImlNuHLLw8CMvHDxDElu1SZBgzdrTkWJ18+5oZpH1S0KUphcmtrbyBTYWtraW5lbiA8amFya2tvLnNha2tpbmVuQHR1bmkuZmk+iQJUBBMBCgA+AhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEUQfmbTR4ipPjInyQOrBUhsd1L+EFAmSlnJ8FCQl1crkACgkQOrBUhsd1L+FwcA//VeqTamEEtfxHKjq2tcx5eclRg8oXVt8V4ba6668uAN0f0gXHC2DcggXCvuSFfpMM5QZMXTMW1Duoh0UJCzhNSyKbblu8EYNGDquLQpgQYaiMUhxSp96FbXUZu7oQMah7QnWXaHJ4Nmw1MzW92HpBT2uGbY1uY8ILAKB5V50coPKtB2pfcU4B67hQvSZNBott0JR071YsD1JVmLRhq0RmQMNlgXE9mpfHU1QjraYcozAAe9aodvRasKsZYSkE+2prbgdaoCTspYUo+gKoYsZEdXqUj4EYm3PhOmnWIlCZ7D/7cBfthYmwpm5wdyhUrRaXNceq7fbJs2DIlYz/hpNZ4ObfCsFDPHAq4OzaYxUVxeVu0E/pEww6z7qquTj2isIGIzIsrhL5miHj8ex
        8ynJIKIDiFdq4EKb1m/lViQK3+wGqWT+xEOmM8uW5fJcuKb87BGxYPVuunlbhVMIW765gpa4y9eY24PF9UNZm13GGGZ7EZ6JNLgIc5ailxJzb4mvCUrhEYzs6det4cnUKqjkSItrFKAnyHRMJwDeYiBSgQycWshOGAiFQ2KPKezTGHrXhOpfsm6s9TRh/lHSIrNMen/ymlgrMs39kVijBpa5P1oVDTrt3X/ayDYTYEqjW6KuerGVx707XkTN+4Mma4EbTBBRoRYDcmFKDVa3Jz39EKdW4MwRdEXSIFgkrBgEEAdpHDwEBB0BPq0RM4xLLKQt+/jDx+bwwwB0k+FzS+69WFoCnK2bNBokCswQYAQoAJgIbAhYhBFEH5m00eIqT4yJ8kDqwVIbHdS/hBQJkw+oYBQkLdNyQAIF2IAQZFggAHRYhBETqlI6doELTQ4QcQhp6uiF0a6vSBQJdEXSIAAoJEBp6uiF0a6vS/LsA/3mk08n5Jb2JwsMfqC0hTzKh3HNXVBNzovB8VKjeyQJfAQDtKhHp/B/gEyxui+peedgm2pGHFxicXWEKtlNZ+DUpBAkQOrBUhsd1L+FCpQ/9EXEtElzGyJdGhsDA27Doo3HbRIVD9sALTqjbRkXKj1salYLVi8hP+6iaxYqWeaP1SjeH9JimqTTOVuClhD9NSkH3a6h6gH6kTLC9H220n3kPGwUDjKpQWiWpq/1HdeUirzdIG30lCzUiyYCB3Oim1A2iGu6RBu/EditQ/f7ExkBiqE6hByX6yk2zKlhlNwc9Sf4LM7uqRoY5B8NIL+a14GbNDXVud/ck5UbnhZ2jFo7Wqg1LUCRypBAFMN48qFOI11Mu+NBVWYNopPNu4R3iTlk4R1X33Bmz0OerXAGIEbokvMKB8s/wBxyXpQzzYKU11vZ06eedu8DWJJTsi6hJmGuK9vsd/8KAmfYDziTCbzsFZB6pGTsfnncJR8K+zIsWMoF8mElYWHp7vB5q
        Qo/bVw5tqC/aWluq1fXJ8ygBkK4OXq9SIXDvw+GnPW/W+1GnyEIL742xUYNjEV5/M0IXJWJIURYSydxvc9FozoDlNQxw+krOM7CODwFvL2+EMVyeRPB8SmeQYjYMXetJIRxyhzWcUUpQCzHzFwOZ2dXmkhmjzS2wpQco5VreTkX5Zka92EnnjLG4Uqo/NOq48T6DrfflYYJXdX8ZOSxTVjSr3fSVYjTuL9Jk+0udh9if3xWcBOFa2jfIlWnitxboDaJiWXRpTSSsGGedIjwdl04/pmu5Ag0EXzMZxQEQALe6fnxvNLCsRcPk8w25P2diHIF92IR4OtxB3cVpzD09mKGUXB95z6LPTS7hts2ZysbRiFPTno9KeohHgOoZIrc3aJqdxLVqcF+A1LtJ7TaNw7KgeyCsMUfozESCRkugVjxeh0Tk08Ma3qs+iLLox43SMo2+4wxD1QWB7ruTLSlZmPION3JcRFlYQiNyn45BcxoUBTfMkJudouBWfsKLNlzCuK7YSUyDS1W/F2Rbn1Bb11KCYJ0XjPBK8s3pdWloLD5+JdX7T1ark9PrmpP+tYL/TI7gFa5kW15fyBfINAEmoTM0qOS8AI0Uji5uVJRA7vNifIVCOXDDTj5p9MWRZlghXZS05ljMlpOD3QNPd9AGQkzGwcdzgbx4X5K94jLW2I6ruN/xu290osLK8is0yWEH31g8DMEVR39f/Du44S2bsvjOhZr7phGO0qI+25p4YZBWvcIRT8v2u09j09+Q87EZRqGczkzYyxJPk09n361a+GMQVfidJijkRKEUET2bTWxrrvmbOs7CwFfCLsCUFm1PiERg3WO9VRVevAQLxbtErLcLSaBT+aWfFcenbdp/1gSSOJgDlkGYrj6rzmjSkF/rXpwsCHN5sPChPm/1WRhj6rW3ectalob0cAfQGY/IRbSOUHWPGrBS+WZZDXi+1lQ4DOsWcChQoNUtN64r7Dm/ABEBAAGJAjYEGAEKA
        CACGyAWIQRRB+ZtNHiKk+MifJA6sFSGx3Uv4QUCY695PQAKCRA6sFSGx3Uv4fW5D/40tdKK/D+GklySOdWr4/eg8yCzAKnEbmYMVsNR0/cjG2ZWtbkqu0oaQS77phCCWcKNO0NGIFOteT1Ai8PcSmw8u4Kva3u7kyqAZF+RSqOFG6kWJ1do0OfAuqUSTYO4Tp7pAGbOnxo1csNL8wleeSMUiHzXDQC5n7DH8fsIeUzqaerrCRbqyCyqqzNIjZUrHFcnW9RwW1PwC5jnNKDvxcxGouieCGtkMWGDDn/hQe9TGrYdMCewgUUKG4UjwEnB6Ve79R1/RIsVX0G/M/T9+/VRXYvS3+b/DDKca0wApIjuN+cA/SNFiRgh5nkquYR3TZan1K72cPkrFresSEA7Vspg+AI1vxC/9jWspQRFu2tE13AT01BpusACXXSTInfkBSa6pXqO6smAbCmuhj2HRbpnC2fx5SyQJliiLzb8YE5ErQkJgSvj3fYr/kdlkJucOfnHgBX9DzEgAmm5WoZeJruCyqO0Md7r0A5R+H7IPmqKmI+1hEylSZqU2XTGd84M9SA7qiPK5hxyA1zT+eic3mKO46l5zn3w5FlMrihZXkUqlmL1N834UU/laM6O7cbXq/VpTn5mQnlTqnieyDboYjW9LBRFb/kjCUTNgRTi7q+Lxpe0hDfOJqAgbG6l/icNCkoUj+9M73qck+DDDwqgHIdhAmeyPwRVf1nU9OnEO92k7bkCDQRiN+yEARAAtzi2qY61jzsEUZsDhPJHERFUwuZ5+eUWrIXKP67umgJEfXdw/veohOVi/8rh4dNQiSOhQFjriknOQr19Q02jibNWSIa56RNZRX0BnSFTWsFq5+PjOjAPgqhf+rDdIPPKZFtRW4W8wR8Qlocd/xP52f1c4y0uJtiQCLbb21KGBnUJ97An87RuVoScVJ08sBxBc3KEnjXJHHvhQa6h6PdVUh0B7HOb9BVttWYPW2XAoB
        YaYiLgz2OII9KD0yRpIS6FIjBVm7W/ZMUZMNwOqZOcroHvb+OPk39OGiCOkJllpbfL6Hlba1pIatSmsqUTZI31FA+4/Vjx7CG89ABbuN6c88ofc6KYqqzBQLhB9p33d6FyGSP+9F33L4MIrTuZ79TUWjckeIbwObd1oti+YS//jnZmTMnEFRvPek3iGIt6QHJ2Ujd/aIwd0N1tutf1AI1heOM2zsK//FzH0Dd4HukWqvyYupVPifVHgu8wGTmQ8+eaMoGrc5ToizsUaVxreKPl5ar55OpJGM+HsoFJJY5/+I1uCWSzl+eCuVQb58RTRe50B8jCF95eY2e8Ns/8SOYZjd8yhDvQA5MrPPeSbnvZXRBcPLRly9gznZTBvakBJts5W01SCEwfHauB4l1TVR3SNy5byhidp/2NICv0fPuPyYYF/Jm9oSWCePRGFMs5hLEAEQEAAYkCPAQYAQgAJhYhBFEH5m00eIqT4yJ8kDqwVIbHdS/hBQJiN+yEAhsMBQkDwmcAAAoJEDqwVIbHdS/hbhQQAIqKJuw59/USsUSRCs98kE8Ajpm0GHD4prgm7pLpWaDb/Z88qlALMOOgA797Rc+B7mCIaYq9uChBhX5di3g8N0yWFUOtJOr0uy43XcnP0Ll+3Wsz19eWct0/Mud/P5Ez0U3absdDOv8lu/ZBy/5JyldzqfCPdIWk030bsvCWOim7O1pisCsO6tWhp5GTaKt39vDw7FeCC48K4K61ueL1wsDFcYYn3ImU2soli4KFdPo1BeJtaCjG/VD1r4Vv8t4lCnSYksCAwV+vcHqBm7GdZKtrBA/TxMjihJqAyEEEigjEA9crIlgxzV27JlaLaNs7qs8AqjYjttq9eoqXPnyg0yqCDlRpnZaTqm2bf1wF3yzWUuTpNXLYbiGymNwqvuBgKxe+1q9SoAslbbyhOoEmDlnDagGtMmQF2xifx6w1VDaMrmEPyVoQNKOH0nu0W3X3aNEo/7PFexT
        zGRp5BUC/QECF1e24osBzH901Cyzz/jCrXFf0ctIHQDRxBgY8UGqH7HVjowv5F3utxH9HxRrd0HvOcL+lMXUHScFHjx15N+NVtchhlWJyrW/wuz4vgLQEOpYYXKZ0yDEb9H6bmeNWh2yUxod4t6tw++Wr8yioJBRaNzU4O2jsO3zQlzWXbJQ8C8BpkV/HdfR5l4bth5U9WnHT6DpEkMB505yipnCge0jduDMEY62jzRYJKwYBBAHaRw8BAQdAoBS/mNv08cEN6n/mweAIA5nhNdKGWyXVpVqcXdQP+auJAjYEGAEIACAWIQRRB+ZtNHiKk+MifJA6sFSGx3Uv4QUCY62jzQIbIAAKCRA6sFSGx3Uv4S+rEACioiDUOR9Go4gflH+lp1HpDF0SqNAUwuLWq3X1SzWaOZKVoHBuXEThJx+zy6niBClgHKpTulc/bqsL9651teYx6N+gbntjdPpyjTXjo10GLvy7wEqb6xeZQMbpBh/FGe3Ns8EqZzgxGOgIJpDCxX2r7uR93DdXMfwklgAZ3RBdBDoOc9ydclhN855bf9h+LoouszCZCznnlQSsGjBv9Ojfn2QNzGd3/cCrL7xS82PguDXopi6oZycp9LpfKKWL7BWmkQT8lgbSrm+QNY4DzMiNPhcqMb+8Yj+V7kqbBS/yWV/kbl5CrI5P/Iz4ZeqKrh07dKUJaj+RGaifW3cZFx/VCHqLxVfa3DwrHtFwQops4/lewpCqBtfx9UWGHRZIfn2Y9EEEmx94ymhO3nN3bVo0GZHCgfcvSDbFgNEefbakVoCAMq6/oiPZTRN0bxktVC7r36lybcbRdCX+MF6OXZb/jjJ71WzkhThEaA+NXx6uaxOvIhgOU0h1qLFkxPpESEYolyhRSs2urvTtbFG/PqHHGlxrl2vLaRee5YJDfvpar+unOY44lfYVdvqd3udMbXhb7FFfajz0iSsok4VwEkh/6BCZ+x8sMSueroMf1jMFsN1LK7Vr
        OhxtP1vYUoyv1iQpYsijVlqHhqbA7Va/jVwBJi40tjMFS0E91mK1iRtBzA==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-12-05 at 21:56 -0500, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
>=20
> When building whole selftests on arm64, rsync gives an erorr about
> sgx:
>=20
> rsync: [sender] link_stat "/root/linux-
> next/tools/testing/selftests/sgx/test_encl.elf" failed: No such file
> or directory (2)
> rsync error: some files/attrs were not transferred (see previous
> errors) (code 23) at main.c(1327) [sender=3D3.2.5]
>=20
> The root casue is sgx only used on X86_64, and shall be skipped on
> other
> platforms.
>=20
> Fix this by moving TEST_CUSTOM_PROGS and TEST_FILES inside the if
> check,
> then the build result will be "Skipping non-existent dir: sgx".
>=20
> Fixes: 2adcba79e69d ("selftests/x86: Add a selftest for SGX")
> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> ---
> =C2=A0tools/testing/selftests/sgx/Makefile | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/sgx/Makefile
> b/tools/testing/selftests/sgx/Makefile
> index 50aab6b57da3..01abe4969b0f 100644
> --- a/tools/testing/selftests/sgx/Makefile
> +++ b/tools/testing/selftests/sgx/Makefile
> @@ -16,10 +16,10 @@ HOST_CFLAGS :=3D -Wall -Werror -g $(INCLUDES) -fPIC
> -z noexecstack
> =C2=A0ENCL_CFLAGS :=3D -Wall -Werror -static -nostdlib -nostartfiles -fPI=
C \
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -fno-stack-protector -mrdrnd =
$(INCLUDES)
> =C2=A0
> +ifeq ($(CAN_BUILD_X86_64), 1)
> =C2=A0TEST_CUSTOM_PROGS :=3D $(OUTPUT)/test_sgx
> =C2=A0TEST_FILES :=3D $(OUTPUT)/test_encl.elf
> =C2=A0
> -ifeq ($(CAN_BUILD_X86_64), 1)
> =C2=A0all: $(TEST_CUSTOM_PROGS) $(OUTPUT)/test_encl.elf
> =C2=A0endif
> =C2=A0

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

